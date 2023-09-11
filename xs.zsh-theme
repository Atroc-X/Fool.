# Clean, simple, compatible and meaningful.
# Tested on Linux, Unix and Windows under ANSI colors.
# It is recommended to use with a dark background.
# Colors: black, red, green, yellow, *blue, magenta, cyan, and white.
#
# Sep 2023 Atroc-X

# VCS
XS_VCS_PROMPT_PREFIX1=" %{$reset_color%}on%{$fg[blue]%} "
XS_VCS_PROMPT_PREFIX2=":%{$fg[cyan]%}"
XS_VCS_PROMPT_SUFFIX="%{$reset_color%}"
XS_VCS_PROMPT_DIRTY=" %{$fg[red]%}x"
XS_VCS_PROMPT_CLEAN=" %{$fg[green]%}o"

# Git info
local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX="${XS_VCS_PROMPT_PREFIX1}git${XS_VCS_PROMPT_PREFIX2}("
ZSH_THEME_GIT_PROMPT_SUFFIX="$XS_VCS_PROMPT_SUFFIX"
ZSH_THEME_GIT_PROMPT_DIRTY=")$XS_VCS_PROMPT_DIRTY"
ZSH_THEME_GIT_PROMPT_CLEAN=")$XS_VCS_PROMPT_CLEAN"

# SVN info
local svn_info='$(svn_prompt_info)'
ZSH_THEME_SVN_PROMPT_PREFIX="${XS_VCS_PROMPT_PREFIX1}svn${XS_VCS_PROMPT_PREFIX2}("
ZSH_THEME_SVN_PROMPT_SUFFIX="$XS_VCS_PROMPT_SUFFIX"
ZSH_THEME_SVN_PROMPT_DIRTY=")$XS_VCS_PROMPT_DIRTY"
ZSH_THEME_SVN_PROMPT_CLEAN=")$XS_VCS_PROMPT_CLEAN"

# HG info
local hg_info='$(XS_hg_prompt_info)'
XS_hg_prompt_info() {
        # make sure this is a hg dir
        if [ -d '.hg' ]; then
                echo -n "${XS_VCS_PROMPT_PREFIX1}hg${XS_VCS_PROMPT_PREFIX2}"
                echo -n $(hg branch 2>/dev/null)
                if [[ "$(hg config oh-my-zsh.hide-dirty 2>/dev/null)" != "1" ]]; then
                        if [ -n "$(hg status 2>/dev/null)" ]; then
                                echo -n "$XS_VCS_PROMPT_DIRTY"
                        else
                                echo -n "$XS_VCS_PROMPT_CLEAN"
                        fi
                fi
                echo -n "$XS_VCS_PROMPT_SUFFIX"
        fi
}

# Virtualenv
local venv_info='$(virtenv_prompt)'
XS_THEME_VIRTUALENV_PROMPT_PREFIX=" %{$fg[green]%}"
XS_THEME_VIRTUALENV_PROMPT_SUFFIX=" %{$reset_color%}%"
virtenv_prompt() {
        [[ -n "${VIRTUAL_ENV:-}" ]] || return
        echo "${XS_THEME_VIRTUALENV_PROMPT_PREFIX}${VIRTUAL_ENV:t}${XS_THEME_VIRTUALENV_PROMPT_SUFFIX}"
}

local exit_code="%(?,,C:%{$fg[red]%}%?%{$reset_color%})"

# ip
function get_ip() {
    local ip_info=$(curl -s -A "Mozilla/5.0" "https://api.ip.sb/geoip")
    local ip=$(echo "$ip_info" | jq -r '.ip')
    echo "$ip"
}

function get_as() {
    local ip=$(get_ip)
    local ip_info=$(curl -s -A "Mozilla/5.0" "https://ipinfo.io/$ip?token=8e4b3479b0ec80")
    echo "$ip_info" | jq -r '"<\(.org | split(" ")[0]) \(.country)>"'
}

# Prompt format:
#
# PRIVILEGES USER @ MACHINE in DIRECTORY on git:BRANCH STATE [TIME] C:LAST_EXIT_CODE
# $ COMMAND
#
# For example:
#
# % XS @ XS-mbp in ~/.oh-my-zsh on git:(master) x [21:47:42] (8.8.8.8) <AS15169  US> C:0
# $
PROMPT="
%{$terminfo[bold]$fg[blue]%}#%{$reset_color%} \
%(#,%{$bg[yellow]%}%{$fg[black]%}%n%{$reset_color%},%{$fg[cyan]%}%n) \
%{$reset_color%}@ \
%{$fg[green]%}%m \
%{$reset_color%}in \
%{$terminfo[bold]$fg[yellow]%}%~%{$reset_color%}\
${hg_info}\
${git_info}\
${svn_info}\
${venv_info}\
 \
[%*] %{$fg[magenta]%}($(get_ip)) %{$fg[red]%}$(get_as)%{$reset_color%} $exit_code
%{$terminfo[bold]$fg[red]%}$ %{$reset_color%}"
