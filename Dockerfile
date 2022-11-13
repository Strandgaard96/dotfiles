FROM ubuntu:20.04



RUN apt-get update && apt-get install build-essential -y
RUN apt-get install -y  git

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y cmake
RUN apt-get -y install zsh
RUN apt-get -y install curl
RUN apt-get -y install wget
RUN apt-get install -y pkg-config
RUN apt-get install -y libssl-dev
RUN apt-get install -y python3.8
RUN apt-get install -y vim

RUN useradd -ms /bin/bash username
COPY --chown=username . /home/username/.dotfiles

ENTRYPOINT cd ~/.dotfiles; bash
