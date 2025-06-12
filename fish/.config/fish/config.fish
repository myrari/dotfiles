# disable greeting
set -g fish_greeting ""

# set editor variable
set -gx EDITOR "nvim"

# easy config reload
function reload
	source "$HOME/.config/fish/config.fish"
end

# short ls alias
function l
	ls -la $argv
end

# add cargo bin
if test -e "$HOME/.cargo"
	fish_add_path "$HOME/.cargo/bin/"
end

if status is-interactive
    # Commands to run in interactive sessions can go here

	# A way to reload the shell à la "zsh"
	function fish
		source ~/.config/fish/config.fish
	end

	# use starship
	starship init fish | source

end
