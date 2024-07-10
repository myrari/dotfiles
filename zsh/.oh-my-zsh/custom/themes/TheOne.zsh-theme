# The One Theme v1.0.0
#
# https://github.com/benniemosher/the-one-theme
#
# Copyright 2015, All rights reserved
#
# Code licensed under the MIT license
# http://benniemosher.mit-license.org
#
# @author Bennie Mosher <benniemosher@gmail.com>

# triangle() {
# 	echo $'\ue0b0'
# }
# 
# arrow_start() {
#    echo "$fg_bold[$ARROW_FG]$bg[$ARROW_BG]%B"
# }
# 
# arrow_end() {
# 	echo "%b$reset_color$fg_bold[$NEXT_ARROW_FG]$bg[$NEXT_ARROW_BG]$(triangle)$reset_color"
# }

# # set the git_prompt_info text
# ZSH_THEME_GIT_PROMPT_PREFIX=""
# ZSH_THEME_GIT_PROMPT_SUFFIX=""
# ZSH_THEME_GIT_PROMPT_DIRTY="*"
# ZSH_THEME_GIT_PROMPT_CLEAN=""
# 
# # set the git_prompt_status text
# ZSH_THEME_GIT_PROMPT_ADDED="$fg[cyan] ✈$reset_color"
# ZSH_THEME_GIT_PROMPT_MODIFIED="$fg[yellow] ✭$reset_color"
# ZSH_THEME_GIT_PROMPT_DELETED="$fg[red] ✗$reset_color"
# ZSH_THEME_GIT_PROMPT_RENAMED="$fg[blue] ➦$reset_color"
# ZSH_THEME_GIT_PROMPT_UNMERGED="$fg[magenta] ✂$reset_color"
# ZSH_THEME_GIT_PROMPT_UNTRACKED="$fg[white] ✱$reset_color"

ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY=" *"
ZSH_THEME_GIT_PROMPT_ADDED="$fg[cyan] ✈$reset_color"
ZSH_THEME_GIT_PROMPT_MODIFIED="$fg[yellow] ✭$reset_color"
ZSH_THEME_GIT_PROMPT_DELETED="$fg[red] ✗$reset_color"
ZSH_THEME_GIT_PROMPT_RENAMED="$fg[blue] ➦$reset_color"
ZSH_THEME_GIT_PROMPT_UNMERGED="$fg[magenta] ✂$reset_color"
ZSH_THEME_GIT_PROMPT_UNTRACKED="$fg[white] ✱$reset_color"

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true

prompt_indicator() {
	echo $'%B\u276f%b'
}

arrow() {
	echo "$bg[$1]$(echo $'\ue0b0')$fg[black]"
}

user() {
	echo "$fg[black]$bg[red] %B%n@%m %b$fg[red]"
}

directory() {
	echo "$(arrow blue) %B%2~ %b$fg[blue]"
}

git_prompt() {
	echo "$(arrow green) %B$(git_prompt_info) %b$fg[green]$(arrow)"
}

# local user="$fg_bold[green]%n$fg_bold[yellow]@$fg_bold[red]%m$reset_color"
# local separator="$fg_bold[yellow]|$reset_color"
# local pwd="$fg_bold[green]%p$fg_bold[blue]%c$reset_color"

PROMPT="$(user)$(directory)$(git_prompt) $reset_color
$(prompt_indicator) "
RPROMPT=""

