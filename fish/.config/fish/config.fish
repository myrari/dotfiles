# disable greeting
set -g fish_greeting ""

# set editor variable
set -gx EDITOR nvim

# easy config reload
function reload
    source "$HOME/.config/fish/config.fish"
end

# short alias to eza (or just ls)
function l
    if type -q eza
		eza -la $argv
	else
        ls -la $argv
    end
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

    # oendark theme
    if set -q VIM
        # Using from vim/neovim.
        set onedark_options -256
    else if string match -iq "eterm*" $TERM
        # Using from emacs.
        function fish_title
            true
        end
        set onedark_options -256
    end

    # custom red colors w/ more saturation
    set_onedark_color red D04134 current
    set_onedark_color brred FB505E current

    set_onedark $onedark_options

    # use starship
    starship init fish | source

end
