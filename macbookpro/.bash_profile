export BASH_SILENCE_DEPRECATION_WARNING=1

[ -r "${HOME}/.bash_aliases" ] && . "${HOME}/.bash_aliases"
[ -r "${HOME}/.bash_paths" ] && . "${HOME}/.bash_paths"




#echo Hello Bash_Profile\!

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

