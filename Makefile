SHELL=/bin/bash
LSB_RELEASE=$(shell lsb_release -cs)

fedora:
	@sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-37.noarch.rpm;
	@sudo dnf install https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-37.noarch.rpm;
	@sudo dnf install fedora-workstation-repositories;
	@sudo dnf config-manager --set-enabled google-chrome;
	@sudo dnf install -y google-chrome;
	@sudo dnf install gtk3 webkit2gtk3 libusb;
	@sudo dnf install -y alacritty zsh g++ stow fzf neovim ripgrep tig tmux;
	@curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh;


setup: check-os
	@echo "Welcome $(shell whoami)!, Let's setup";
	@make zsh-setup;
	@make pkg-setup;
	@make dotfiles-setup;


dotfiles-setup: 
	@echo "=== .dotfiles";
	@( \
		if  [ -z $(shell which stow) ]; then \
			echo "You haven't run make pkg-setup. Please do first"; \
			exit 1; \
		else \
			for folder in zsh nvim tmux bin; do \
				echo "====== stow $$folder"; \
				stow -D $$folder;\
				stow $$folder; \
			done \
		fi \
	)

tmux-setup: dotfiles-setup
	@echo "=== TMUX";
	@( \
		if [ ! -d "$$HOME/.tmux/plugins/tpm" ]; then \
			echo "====== Downloading tpm"; \
			git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm; \
		fi; \
		echo "====== Loading tmux conf"; \
		tmux source $$HOME/.tmux.conf; \
	)


pkg-setup: 
	@echo "=== Installing packages";
	@sudo add-apt-repository ppa:neovim-ppa/stable -y;
	@sudo apt-get update;
	@sudo apt-get install -y gnupg software-properties-common curl;
	@echo "====== Utilities";
	@sudo apt-get install -y stow fzf ripgrep ack tig tmux neovim fonts-powerline jq;
	@sudo apt-get install -y python3-dev python3-pip python3-setuptools;
	@sudo apt-get install -y python3-dev python3-pip python3-setuptools;
	@sudo curl https://sh.rustup.rs -sSf | sh -s -- -y
	@( \
		if  [ -z $(shell which nvm) ]; then \
			curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash; \
		fi; \
	)
	@echo "====== LSPs";
	@sudo apt-get install -y clangd;
	@npm install -g typescript-language-server typescript pyright;
	@mkdir -p ~/.local/bin
	@curl -L https://github.com/rust-lang/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/.local/bin/rust-analyzer
	@chmod +x ~/.local/bin/rust-analyzer


zsh-setup:
	@echo "=== ZSH";
	@( \
		if [ -z $(shell which zsh) ]; then \
			echo "====== Installing zsh"; \
			sudo apt-get install zsh -y; \
			sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"; \
			chsh -s $(shell which zsh) $(shell whoami); \
		else \
			echo "====== zsh already installed in $(shell which zsh)"; \
		fi \
	)


tf-setup:
	@echo "=== Setting up Terraform";
	@( \
		if [ -z $(shell which tfswitch) ]; then \
			echo "====== Installing tfswitch"; \
			curl -L https://raw.githubusercontent.com/warrensbox/terraform-switcher/release/install.sh | sudo bash; \
		else \
			echo "====== tfswitch already installed in $(which tfswitch)"; \
		fi \
	)
	@sudo tfswitch --latest

check-os:
	@echo "=== What are we working on?"
	@( \
		if [ -f "/etc/os-release" ]; then \
			. /etc/os-release; \
			if [ "$$NAME" = "Ubuntu" ] && grep -q "20.04" <<< "$$VERSION"; then \
				echo "====== Let's start installing everying for $$NAME:$$VERSION"; \
			else \
				echo "====== We have no setup instructions for this place"; \
				exit 0; \
			fi \
		else \
			echo "No /etc/os-release found"; \
			exit 0; \
		fi \
	)



.PHONY: setup
