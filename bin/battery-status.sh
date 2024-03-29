#!/usr/bin/env bash
#
# battery-status
#
# A quick little indicator for battery status on your Mac laptop, suitable for
# display in your prompt.

# Copied from github.com/ginatrapani/dotfiles/bin/battery-status

__battery_status() {
    battstat=$(pmset -g batt)
    time_left=$(echo $battstat \
            | tail -1 \
            | cut -f2 \
            | awk -F"; " '{print $3}' \
            | cut -d' ' -f1)

    if [[ $(pmset -g ac) == *"No adapter attached."* ]]; then
        emoji='🔋'
    else
        emoji='🔌'
    fi

    if [[ $time_left == *"(no"* || $time_left == *"not"* ]]; then
        time_left='⌛️ '
    fi

    if [[ $time_left == *"0:00"* ]]; then
        time_left='⚡️ '
    fi

    printf "\033[1;92m$emoji  $time_left \033[0m"
}

# For when you want that ~ \newline ~
batstat() {
    echo $(__battery_status)
}
