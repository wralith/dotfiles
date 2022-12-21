set -gx PATH $PATH ~/.cargo/bin
set -gx PATH $PATH ~/.local/bin
set -gx PATH $PATH $(go env GOPATH)/bin
set -gx PATH $PATH /home/wralith/.dapr/bin

alias k="kubectl"

eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)

# pnpm
set -gx PNPM_HOME "/home/wralith/.local/share/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end
