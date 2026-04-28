if status is-interactive
    # Commands to run in interactive sessions can go here
    zoxide init fish | source
    starship init fish | source

end

set -Ux FZF_DEFAULT_OPTS "\
--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
--color=selected-bg:#45475A \
--color=border:#6C7086,label:#CDD6F4"

fish_config theme choose "crimson"
# fish_config theme choose "ashen"
# fish_config theme choose "poimandres"
# fish_config theme choose catppuccin-mocha --color-theme=dark
# fish_config theme choose poimandres_darker
# fish_config theme choose night_rider

alias l='lsd -l'
alias la='lsd -a'
alias lla='lsd -la'
alias lt='lsd --tree'

function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    command yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /Users/maelho/.lmstudio/bin
# End of LM Studio CLI section

set --export oxc_language_server /Users/maelho/code/oxc/crates/oxc_language_server

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# go
set -gx PATH $PATH (go env GOPATH)/bin

# Helix
set --export HELIX_RUNTIME "$HOME/helix/runtime"
set -gx EDITOR hx

# pnpm
set -gx PNPM_HOME /Users/maelho/Library/pnpm
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# dev

set --export GREENLIGHT_DB_DSN "postgresql://greenlight:nosenose@localhost:5432/greenlight?sslmode=disable"
# Vite+ bin (https://viteplus.dev)
source "$HOME/.vite-plus/env.fish"
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH
~/.local/bin/mise activate fish | source
