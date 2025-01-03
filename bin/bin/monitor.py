#!/usr/bin/env python3

import subprocess
import copy


def shell(cmd, shell=False):

    if shell:
        p = subprocess.Popen(
            cmd,
            shell=True,
            stdin=subprocess.PIPE,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
        )
    else:
        cmd = cmd.split()
        p = subprocess.Popen(
            cmd, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE
        )

    output, _ = p.communicate()
    return output.decode("utf-8")


def get_monitors():

    xrandrs = shell(
        'xrandr | grep "connected" | grep -v "disconnected"', shell=True
    ).split("\n")

    monitors = []
    resolutions = []

    for xrandr in xrandrs[:-1]:
        xrandr = xrandr.split()
        monitor = xrandr[0]
        resolution = xrandr[2]

        monitors.append(monitor)
        resolutions.append(resolution)

    return monitors, resolutions


def set_monitor(monitor, resolution="auto", position=None, debug=False):

    cmd = ["xrandr"]
    cmd += ["--output " + monitor]

    if resolution == "auto":
        cmd += ["--auto"]
    elif resolution == "off" or not resolution:
        cmd += ["--off"]
    else:
        cmd += ["--mode " + resolution]

    if position is not None:
        cmd += [position]

    cmd = " ".join(cmd)

    if debug:
        print(cmd)

    shell(cmd, shell=True)

    return


def main():
    """
    NOTE
    xrandr
    --output VIRTUAL1 --off
    --output eDP1 --primary --mode 1600x900
    --pos 5120x540 --rotate normal
    --output DP1 --off --output DP2-1 --off
    --output DP2-2 --mode 2560x1440 --pos 2560x0 --rotate normal
    --output DP2-3 --off
    --output HDMI1 --mode 2560x1440 --pos 0x0 --rotate normal
    --output DP1-3 --off
    --output DP1-2 --off
    --output DP1-1 --off
    --output DP2 --off

    """

    import argparse
    import sys

    parser = argparse.ArgumentParser()
    parser.add_argument("--native", type=str, help="", default="eDP-1", metavar="X")
    parser.add_argument("--refresh", "-r", action="store_true")
    parser.add_argument("--dock", "-d", action="store_true")
    parser.add_argument("--undock", "-u", action="store_true")
    parser.add_argument(
        "--debug", action="store_true", help="Print all xrandr commands"
    )
    args = parser.parse_args()

    native_res = "1920x1080"
    # native_res="1600x900"

    if len(sys.argv) == 1:
        for monitor, resolution in zip(*get_monitors()):
            print(monitor, resolution)
        sys.exit()

    monitors, resolutions = get_monitors()

    external_monitors = copy.copy(monitors)
    external_resolutions = copy.copy(resolutions)
    native_idx = external_monitors.index(args.native)

    external_monitors.pop(native_idx)
    external_resolutions.pop(native_idx)

    # TODO reorder more general
    external_monitors = list(reversed(external_monitors))
    external_resolutions = list(reversed(external_resolutions))

    if args.refresh:

        # only external 2
        if len(external_monitors) >= 2:
            set_monitor(external_monitors[1], resolution="off", debug=args.debug)
            args.dock = True

    if args.undock:

        set_monitor(args.native, resolution=native_res, debug=args.debug)

        for monitor, resolution in zip(external_monitors, external_resolutions):
            set_monitor(monitor, resolution="off", debug=args.debug)

    elif args.dock:

        if len(external_monitors) == 0:
            quit("No external monitors")

        previous = args.native
        set_monitor(args.native, resolution=native_res, debug=args.debug)

        for monitor, resolution in zip(external_monitors, external_resolutions):
            print(monitor, resolution)

            if previous is None:
                pos = "--pos 0x0"
            else:
                pos = "--right-of " + previous

            set_monitor(monitor, resolution="auto", debug=args.debug, position=pos)

            previous = monitor

    else:

        set_monitor(args.native, resolution=native_res, debug=args.debug)

    # Be sure to refresh desktop image and polybar at the end
    shell("polybar-msg cmd restart", shell=True)
    shell("nitrogen --restore", shell=True)

    return


if __name__ == "__main__":
    main()
