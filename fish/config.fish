set fish_greeting ""

# import config files
source (dirname (status --current-filename))/aliases.fish
source (dirname (status --current-filename))/themes/tokyonight_night.fish
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

set -gx EDITOR nvim

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH
set -gx PATH /opt/homebrew/bin $PATH
set -gx PATH /opt/homebrew/sbin $PATH

# NodeJS
set -gx PATH node_modules/.bin $PATH

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

# Pyenv
# set -Ux PYENV_ROOT $HOME/.pyenv
# set -gx PATH $PYENV_ROOT/bin $PATH
# pyenv init - | source
# alias brew="env PATH=(string replace (pyenv root)/shims '' \"\$PATH\") brew"
# status --is-interactive; and pyenv virtualenv-init - | source

# set -gx PATH $HOME/.pyenv/bin $PATH
# pyenv init - | source
# status --is-interactive; and pyenv virtualenv-init - | source

# set -x PATH $HOME/.pyenv/bin $PATH
# status --is-interactive; and . (pyenv init - | source)
# status --is-interactive; and . (pyenv virtualenv-init - | source)
# set -x PYENV_VERSION (cat ~/.pyenv/version)

# set -Ux PYENV_ROOT $HOME/.pyenv
# set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths
# pyenv init - | source
# status --is-interactive; and . (pyenv init - | source)
# status --is-interactive; and . (pyenv virtualenv-init - | source)

# SSH
# eval $(ssh-agent -c)

# pnpm
set -gx PNPM_HOME /Users/vyductan/Library/pnpm
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
