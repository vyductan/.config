alias ls "ls -p -G"
alias la "ls -A"
alias ll "ls -l"
alias lla "ll -A"
alias g git
alias lz lazygit
alias n "nvim $args"
function cf
    cd ~/.config/$argv[1] && n
end
# alias nfish "nvim ~/.config/fish/config.fish"
# alias nnvim "nvim ~/.config/nvim/init.lua"
# alias nyabai "cd ~/.config/yabai && n"
# alias nskhd "cd ~/.config/skhd && n"

alias rs "brew services restart $args"
# alias rpostgress "brew services restart postgresql@14"
