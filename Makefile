SHELL=/bin/bash
LSB_RELEASE=$(shell lsb_release -cs)


MACOS_PACKAGES=
FEDORA_PACKAGES=g++ gtk3 webkit2gtk3 libusb rofi nitrogen polybar autorandr playerctl maim i3 picom alacritty \
		docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin \
		openssl-devel lutris wine steam google-chrome mycli postgresql discord fd-find ffmpeg

GLOBAL_PACKAGES=zsh stow fzf neovim ripgrep tig tmux tldr xclip openssl 

setup: 
	@echo "Welcome $(shell whoami)!, Let's setup";
	@make pkg-setup;
	@make dotfiles-setup;
	@make zsh-setup;
	@make tmux-setup;

clean-fedora:
	# This one should completely go once I make an image from fedora server edition
	@sudo dnf remove firefox konsole;

pkg-mac:
	@brew install $(GLOBAL_PACKAGES) $(MACOS_PACKAGES);

pkg-setup:
	@sudo dnf -y update;
	@sudo dnf install -y dnf-plugins-core;
	@sudo dnf config-manager --set-enabled google-chrome;
	@sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo;
	@( \
		sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-37.noarch.rpm \
		https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-37.noarch.rpm \
		fedora-workstation-repositories; \
	)
	@( \
		sudo rpm -v --import https://yum.tableplus.com/apt.tableplus.com.gpg.key; \
		sudo dnf config-manager --add-repo https://yum.tableplus.com/rpm/x86_64/tableplus.repo; \
	)
	@sudo dnf install -y $(GLOBAL_PACKAGES) $(FEDORA_PACKAGES);
	@echo "LSP"
	@sudo dnf install -y rust-analyzer;

rust:
	@curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh;

rust-toolchain:
	@cargo install cargo-watch cargo-audit cargo-asm cargo-license 
	@cargo install sqlx-cli --no-default-features --features rustls,mysql,postgres

dotfiles-setup: 
	@echo "=== .dotfiles";
	@( \
		if  [ -z $(shell which stow) ]; then \
			echo "You haven't run make pkg-setup. Please do first"; \
			exit 1; \
		else \
			for folder in i3 zsh alacritty picom rofi nvim tmux bin; do \
				echo "====== stow $$folder"; \
				stow -D $$folder;\
				stow $$folder; \
			done \
		fi \
	)

tmux-setup: 
	@echo "=== TMUX";
	@( \
		if [ ! -d "$$HOME/.tmux/plugins/tpm" ]; then \
			echo "====== Downloading tpm"; \
			git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm; \
		fi; \
		echo "====== Loading tmux conf"; \
		tmux source $$HOME/.tmux.conf; \
	)

zsh-setup:
	@echo "=== ZSH";
	@( \
		if [ ! -d "$$HOME/.oh-my-zsh" ]; then \
			echo "=== Oh my zsh"; \
			sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"; \
			chsh -s $(shell which zsh) $(shell whoami); \
		fi; \
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


.PHONY: setup
