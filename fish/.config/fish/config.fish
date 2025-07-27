# disable greeting
set -g fish_greeting ""

# set editor variable
set -gx EDITOR nvim

# easy config reload
function reload
    source "$HOME/.config/fish/config.fish"
end

# homebrew
if test -e /opt/homebrew/bin
	set --global --export HOMEBREW_PREFIX "/opt/homebrew";
	set --global --export HOMEBREW_CELLAR "/opt/homebrew/Cellar";
	set --global --export HOMEBREW_REPOSITORY "/opt/homebrew";
	fish_add_path --global --move --path "/opt/homebrew/bin" "/opt/homebrew/sbin";
	if test -n "$MANPATH[1]"; set --global --export MANPATH '' $MANPATH; end;
	if not contains "/opt/homebrew/share/info" $INFOPATH; set --global --export INFOPATH "/opt/homebrew/share/info" $INFOPATH; end;
end

# short alias to eza (or just ls)
function l
    if type -q eza
		eza -lah $argv
	else
        ls -lah $argv
    end
end

# add cargo bin
set -lx RUSTUP_PATH (brew --prefix rustup)
if test -e "$RUSTUP_PATH"
    fish_add_path "$RUSTUP_PATH/bin/"
end

# ssh agent
fish_ssh_agent

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
