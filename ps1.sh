# prompt
PROMPT_COMMAND=custom_prompt

custom_prompt() {
    local exit_code="$?"
    local white_bold="\\[\e[1;38;5;255m\\]"
    local blue_bold="\\[\e[1;38;5;39m\\]"
    local dark_blue_bold="\\[\e[1;38;5;33m\\]"
    local green_bold="\\[\e[1;38;5;46m\\]"
    local red_bold="\\[\e[1;38;5;160m\\]"
    local light_red_bold="\\[\e[1;38;5;203m\\]"
    local yellow_bold="\\[\e[1;38;5;226m\\]"
    local reset_prompt="\\[\e[0m\\]"
    local fg_bg_user="\\[\e[1;48;5;33m\\]"
    local fg_bg_root="\\[\e[1;48;5;160m\\]"
    local user_prompt_style="\\[\e[1;38;5;255m\\]\\$\\[\e[0m\\]"
    local root_prompt_style="\\[\e[1;38;5;255m\\]\\$\\[\e[0m\\]"
    local git_branch=$(git branch 2>/dev/null | grep '*' | sed 's/* \(.*\)/\1/' || "")

    if [[ $UID == 0  ]]
    then
        local show_username="${fg_bg_root} ${reset_prompt} ${red_bold}$USER${reset_prompt}${root_prompt_style} "
    else
        local show_username="${fg_bg_user} ${reset_prompt} ${dark_blue_bold}$USER${reset_prompt}${user_prompt_style} "
    fi

    if [[ $exit_code == 0 ]]
    then
        local show_exit="${white_bold}< 😃 ec=${exit_code} >${reset_prompt}"
    else
        local show_exit="${white_bold}< 🙁 ec=${red_bold}${exit_code}${white_bold} >${reset_prompt}"
    fi

    if [[ $VIRTUAL_ENV_PROMPT != "" ]]
    then
        local python_venv=" ${white_bold}< ${green_bold} ${yellow_bold}${VIRTUAL_ENV_PROMPT}${white_bold} >${reset_prompt}"
    else
        local python_venv=""
    fi

    if [[ $git_branch != "" ]]
    then
        local show_git_branch="${white_bold}< ${green_bold} ${yellow_bold}${git_branch} ${white_bold}>${reset_prompt}"
    else
        local show_git_branch=""
    fi

    PS1=""

    local host_name=$(hostname)
    local show_date_time="${white_bold}[${blue_bold}\\D{%F} \\D{%H:%M:%S}${white_bold}]${reset_prompt}"
    local show_current_directory="${white_bold}󰘍 ${host_name}${red_bold}:${green_bold}\\w${reset_prompt}"

    PS1="${show_date_time} ${show_exit}${python_venv} ${show_git_branch}\\n${show_current_directory}\\n${show_username}"
}
