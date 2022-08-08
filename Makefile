SHELL=/bin/bash
LSB_RELEASE=$(shell lsb_release -cs)


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
			for folder in zsh nvim tmux; do \
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
	@sudo apt-get install -y stow fzf ripgrep ack tig tmux neovim terraform fonts-powerline jq;
	@sudo apt-get install -y python3-dev python3-pip python3-setuptools;
	@pip3 install thefuck --user;
	@echo "====== LSPs";
	@sudo apt-get install -y terraform-ls;
	@npm install -g typescript-language-server typescript;


zsh-setup:
	@echo "=== ZSH";
	@( \
		if [ -z $(shell which zsh) ]; then \
			echo "====== Installing zsh"; \
			sudo apt-get install zsh -y; \
			curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh | \
				sudo bash; \
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
