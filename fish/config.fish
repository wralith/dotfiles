if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -gx DENO_INSTALL /home/wralith/.deno

set -gx PATH $PATH ~/.cargo/bin
set -gx PATH $PATH ~/.local/bin
set -gx PATH $PATH $(go env GOPATH)/bin
set -gx PATH $PATH /home/wralith/.dapr/bin
set -gx PATH $PATH $DENO_INSTALL/bin:$PATH
set -g QT_QPA_PLATFORMTHEME "gtk2"
source ~/.asdf/asdf.fish


# k8s
alias k="kubectl"

alias davinci="NV_PRIME_RENDER_OFFLOAD=1 GLX_VENDOR_LIBRARY_NAME=nvidia /opt/resolve/bin/resolve"

alias lg="lazygit"

# rust
alias cac="cargo check"
alias car="cargo run"
alias ccl="cargo clippy"

eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)

# pnpm
set -gx PNPM_HOME "/home/wralith/.local/share/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end
