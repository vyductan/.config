set fish_greeting ""

source (dirname (status --current-filename))/aliases.fish
switch (uname)
    case Darwin
        source (dirname (status --current-filename))/config-osx.fish
    case Linux
        source (dirname (status --current-filename))/config-linux.fish
    case '*'
        source (dirname (status --current-filename))/config-windows.fish
end

set LOCAL_CONFIG (dirname (status --current-filename))/config-local.fish
if test -f $LOCAL_CONFIG
    source $LOCAL_CONFIG
end
# set -gx TERM xterm-256color

# theme
# set -g theme_color_scheme tokyonight_moon
# set -g fish_prompt_pwd_dir_length 1
# set -g theme_display_user yes
# set -g theme_hide_hostname no
# set -g theme_hostname always


# command -qv nvim && alias vim nvim

set -gx EDITOR nvim

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH
set -gx PATH /opt/homebrew/bin $PATH
set -gx PATH /opt/homebrew/sbin $PATH

# NodeJS
set -gx PATH node_modules/.bin $PATH

# Go
# set -g GOPATH $HOME/go
# set -gx PATH $GOPATH/bin $PATH

# NVM
# function __check_rvm --on-variable PWD --description 'Do nvm stuff'
#     status --is-command-substitution; and return
#
#    if test -f .nvmrc; and test -r .nvmrc
#         nvm use
#    else
#    end
# end

# CoreUtils (sha56md5)
set -gx PATH /opt/homebrew/opt/coreutils/libexec/gnubin $PATH

# Python
set -gx PATH /opt/homebrew/opt/python/libexec/bin $PATH

# Postgresql
# set -gx PATH /opt/homebrew/opt/postgresql@15/bin $PATH
# set -gx LDFLAGS "-L/opt/homebrew/opt/postgresql@15/lib"
# set -gx CPPFLAGS "-I/opt/homebrew/opt/postgresql@15/include"
# set -gx PKG_CONFIG_PATH "/opt/homebrew/opt/postgresql@15/lib/pkgconfig"

# set -gx PATH /opt/homebrew/opt/postgresql@14/bin $PATH
# set -gx LDFLAGS -L/opt/homebrew/opt/postgresql@14/lib
# set -gx CPPFLAGS -I/opt/homebrew/opt/postgresql@14/include
# set -gx PKG_CONFIG_PATH /opt/homebrew/opt/postgresql@14/lib/pkgconfig

# set -gx PATH /opt/homebrew/opt/libpq/bin $PATH

# set -gx LDFLAGS "-L/opt/homebrew/opt/libpq/lib -L/opt/homebrew/opt/openssl@3/lib" $LDFLAGS
# set -gx CPPFLAGS "-I/opt/homebrew/opt/libpq/include -I/opt/homebrew/opt/openssl@3/include" $CPPFLAGS
# set -gx PKG_CONFIG_PATH /opt/homebrew/opt/libpq/lib/pkgconfig $PKG_CONFIG_PATH



# TokyoNight Moon Color Palette
# Jan 18
set -l foreground c8d3f5
set -l selection 3654a7
set -l comment 636da6
set -l red ff757f
set -l orange ff966c
set -l yellow ffc777
set -l green c3e88d
set -l purple fca7ea
set -l cyan 86e1fc
set -l pink c099ff

# Syntax Highlighting Colors
set -g fish_color_normal $foreground
set -g fish_color_command $cyan
set -g fish_color_keyword $pink
set -g fish_color_quote $yellow
set -g fish_color_redirection $foreground
set -g fish_color_end $orange
set -g fish_color_error $red
set -g fish_color_param $purple
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $green
set -g fish_color_escape $pink
set -g fish_color_autosuggestion $comment

# Completion Pager Colors
set -g fish_pager_color_progress $comment
set -g fish_pager_color_prefix $cyan
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $comment
set -g fish_pager_color_selected_background --background=$selection

# Pyenv
# set -Ux PYENV_ROOT $HOME/.pyenv
# set -gx PATH $PYENV_ROOT/bin $PATH
# pyenv init - | source
# alias brew="env PATH=(string replace (pyenv root)/shims '' \"\$PATH\") brew"
# status --is-interactive; and pyenv virtualenv-init - | source
set -gx PATH $HOME/.pyenv/bin $PATH
pyenv init - | source
status --is-interactive; and pyenv virtualenv-init - | source

# SSH
eval $(ssh-agent -c)

# pnpm
set -gx PNPM_HOME "/Users/vyductan/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end