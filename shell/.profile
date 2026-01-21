eval "$(dircolors -b)"

export BAT_THEME=base16
export BATDIFF_USE_DELTA=true
export FZF_DEFAULT_OPTS='--color=16 --bind=alt-j:down,alt-k:up --cycle'

export SKIM_DEFAULT_OPTIONS='--color=16 --bind=alt-j:down,alt-k:up --cycle'
export SKIM_DEFAULT_COMMAND='fd --hidden --type f --type l --exclude .git'

export RIPGREP_CONFIG_PATH=$HOME/.config/.ripgreprc
export CARGO_TARGET_DIR=$HOME/.cache/.cargo
export TYPST_PACKAGE_PATH=$HOME/templates/typst/packages
