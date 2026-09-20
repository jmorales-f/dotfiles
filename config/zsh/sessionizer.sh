function sessionizer() {
    local workspaces=(${=WORKSPACES})
    local search_dirs=(
        "${workspaces[@]/#/$HOME/}"
    )

    local rows cols
    rows=$(tput lines)
    cols=$(tput cols)

    local pad_v
    pad_v=$(( rows / 12 ))
    (( pad_v < 2 )) && pad_v=2
    (( pad_v > 6 )) && pad_v=6

    local pad_h
    if (( cols >= 160 )); then
        pad_h=$(( cols / 6 ))
    elif (( cols >= 120 )); then
        pad_h=$(( cols / 10 ))
    else
        pad_h=2
    fi

    local GREEN=$'\e[32m'
    local YELLOW=$'\e[33m'
    local GRAY=$'\e[90m'
    local RESET=$'\e[0m'

    strip_ansi() {
      sed -E 's/\x1B\[[0-9;]*[mK]//g'
    }

    typeset -A SESSION_STATUS
    while IFS= read -r raw; do
        local line=$(strip_ansi <<< "$raw")
        local name="${line%% *}"
        if [[ "$line" == *"(EXITED"* ]]; then
            SESSION_STATUS["$name"]="EXITED"
        else
            SESSION_STATUS["$name"]="ACTIVE"
        fi
    done < <(zellij list-sessions 2>/dev/null)

    local -a repos
    repos=("${(@f)$(find "${search_dirs[@]}" -maxdepth 2 -name ".git" -type d -exec dirname {} \; 2>/dev/null)}")
    local -a tagged_repos

    for repo in "${repos[@]}"; do
        local session_name="${repo:t}"
        local session_status="${SESSION_STATUS["$session_name"]:-NONE}"
        local tag=""

        case "$session_status" in
            ACTIVE)
                tag="${GREEN}●${RESET}"
                ;;
            EXITED)
                tag="${YELLOW}●${RESET}"
                ;;
            NONE)
                tag="${GRAY}●${RESET}"
                ;;
        esac

        tagged_repos+=("$tag  $repo")
    done


    local user_input=$(
        print -rl -- "${tagged_repos[@]}" |
        fzf \
            --ansi \
            --expect=enter,ctrl-x,ctrl-d \
            --border=sharp \
            --layout=reverse \
            --border-label="Sessionizer" \
            --color="label:#c4a7e7" \
            --ghost="Select a repository to attach to or manage its session." \
            --footer="enter: attach   ctrl-x: stop   ctrl-d: delete" \
            --footer-border=sharp \
            --header-first \
            --prompt="> " \
            --info=hidden \
            --list-border=sharp \
            --padding="$pad_v,$pad_h,$pad_v,$pad_h"
    )

    if [[ -z "$user_input" ]]; then
      echo "No selection."
      return 0
    fi

    local key raw_repo
    key="${user_input%%$'\n'*}"
    raw_repo="${user_input#*$'\n'}"

    local repo="${raw_repo##*  }"
    local session_name="${repo:t}"
    local session_status="${SESSION_STATUS["$session_name"]:-NONE}"

    case "$key" in
        ctrl-x)
            [[ $session_status == ACTIVE ]] && zellij kill-session $session_name
            sessionizer
            ;;
        ctrl-d)
            [[ $session_status != NONE ]] && zellij delete-session $session_name
            sessionizer
            ;;
        enter)
            cd "$repo"
            zellij attach -c $session_name
            return 1
            ;;
    esac
}
bindkey -s '^a' 'sessionizer\n'
