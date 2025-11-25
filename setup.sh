#!/usr/bin/env bash

set -e

NVIM_DIR="$HOME/.config/nvim-test"
PACK_DIR="$NVIM_DIR/pack/akshikrm/start"

echo "Creating Neovim directory structure..."
mkdir -p "$PACK_DIR"

cd "$PACK_DIR"

clone() {
	local repo=$1
	local name=$(basename "$repo")

	if [ -d "$name" ]; then
		echo "$name already exists — skipping"
	else
		echo "Cloning $repo..."
		git clone --depth 1 "$repo"
	fi
}

clone https://github.com/saghen/blink.cmp
clone https://github.com/stevearc/conform.nvim
clone https://github.com/neovim/nvim-lspconfig
clone https://github.com/kylechui/nvim-surround
clone https://github.com/nvim-treesitter/nvim-treesitter
clone https://github.com/christoomey/vim-tmux-navigator

echo "Neovim package setup complete!"
