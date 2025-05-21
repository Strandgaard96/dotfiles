if test -f ~/.bash_profile.local; then
    . ~/.bash_profile.local
fi

if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# Save a ton of history
HISTSIZE=2000000
HISTFILE=~/.history
SAVEHIST=2000000

# export LC_ALL=en_US.UTF-8
# export LANG=en_US.UTF-8
# BEGIN_AWS_SSO_CLI
__aws_sso_profile_complete() {
    COMPREPLY=()
    local _args=${AWS_SSO_HELPER_ARGS:- -L error --no-config-check}
    local cur
    _get_comp_words_by_ref -n : cur

    COMPREPLY=($(compgen -W '$(/home/linuxbrew/.linuxbrew/Cellar/aws-sso-cli/1.17.0/bin/aws-sso $_args list --csv -P "Profile=$cur" Profile)' -- ""))

    __ltrim_colon_completions "$cur"
}

aws-sso-profile() {
    local _args=${AWS_SSO_HELPER_ARGS:- -L error --no-config-check}
    if [ -n "$AWS_PROFILE" ]; then
        echo "Unable to assume a role while AWS_PROFILE is set"
        return 1
    fi

    if [ -z "$1" ]; then
        echo "Usage: aws-sso-profile <profile>"
        return 1
    fi

    eval $(/home/linuxbrew/.linuxbrew/Cellar/aws-sso-cli/1.17.0/bin/aws-sso $_args eval -p "$1")
    if [ "$AWS_SSO_PROFILE" != "$1" ]; then
        return 1
    fi
}

aws-sso-clear() {
    local _args=${AWS_SSO_HELPER_ARGS:- -L error --no-config-check}
    if [ -z "$AWS_SSO_PROFILE" ]; then
        echo "AWS_SSO_PROFILE is not set"
        return 1
    fi
    eval $(aws-sso eval $_args -c)
}

complete -F __aws_sso_profile_complete aws-sso-profile
complete -C /home/linuxbrew/.linuxbrew/Cellar/aws-sso-cli/1.17.0/bin/aws-sso aws-sso

