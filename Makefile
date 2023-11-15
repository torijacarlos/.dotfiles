SHELL=/bin/bash

FEDORA_VERSION_ID=$(shell rpm -E %fedora)
FEDORA_MIRRORS=https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(FEDORA_VERSION_ID).noarch.rpm \
	https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(FEDORA_VERSION_ID).noarch.rpm \
	fedora-workstation-repositories

OH_MY_ZSH_INSTALL=https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh
DOTFILES_APPS=sway wofi waybar zsh alacritty nvim tmux bin git libvirt

LAPTOP_PACKAGES=playerctl brightnessctl

GLOBAL_PACKAGES=fzf neovim ripgrep tig tmux tldr openssl htop rclone
UTILS_PACKAGES=g++ gtk3 webkit2gtk3 libusb ImageMagick sqlite \
	openssl-devel fd-find ffmpeg pandoc groff ghostscript 
DEV_PACKAGES=alacritty heaptrack jq cmake gdb
AUDIO_PACKAGES=pipewire-pulseaudio alsa-utils alsa-firmware alsa-plugins-pulseaudio

XORG_PACKAGES=i3 rofi polybar nitrogen autorandr arandr picom nautilus
WAYLAND_PACKAGES=sway slurp wofi waybar wl-clipboard grim wlr-randr thunar

APP_PACKAGES=krita audacity obs-studio discord google-chrome 
FONTS_PACKAGES=google-noto-emoji-color-fonts google-noto-cjk-fonts

setup: 
	@echo "Welcome $(shell whoami)!, Let's setup";
	@make base;
	@make zsh-setup;
	@make dotfiles;
	@make tmux-setup;
	@make rust;
	@make packages;

base:
	@sudo dnf -y update;
	@sudo dnf install -y dnf-plugins-core $(FEDORA_MIRRORS);
	@sudo dnf config-manager --set-enabled google-chrome;
	@sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo;

packages:
	@sudo dnf install -y $(GLOBAL_PACKAGES) $(UTILS_PACKAGES) $(LAPTOP_PACKAGES); 
	@sudo dnf install -y $(DEV_PACKAGES) $(WAYLAND_PACKAGES) $(APP_PACKAGES) $(FONTS_PACKAGES);
	@sudo dnf install -y $(AUDIO_PACKAGES) --allowerasing --skip-broken --best;
	@sudo dnf swap wireplumpler pipewire-media-session;
	@gsettings set org.gnome.desktop.interface color-scheme prefer-dark;


zsh-setup: 
	@echo "=== ZSH";
	@sudo dnf install -y zsh;
	@( \
		if [ ! -d "$$HOME/.oh-my-zsh" ]; then \
			echo "=== Oh my zsh"; \
			curl -fsSL $(OH_MY_ZSH_INSTALL) | sh; \
			chsh -s $(shell which zsh) $(shell whoami); \
			rm ~/.zshrc; \
		fi; \
	)


dotfiles: 
	@echo "=== .dotfiles";
	@( \
		if command -v stow &> /dev/null; then \
			for folder in $(DOTFILES_APPS); do \
				echo "====== stow $$folder"; \
				stow -D $$folder;\
				stow $$folder; \
			done; \
			echo "===== hard copy greetd"; \
			sudo rm /etc/greetd/*; \
			sudo cp -t /etc/greetd greetd/config.toml greetd/sway-config; \
		fi \
	)


tmux-setup: dotfiles
	@echo "=== TMUX";
	@( \
		if [ ! -d "$$HOME/.tmux/plugins/tpm" ]; then \
			echo "====== Downloading tpm"; \
			git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm; \
		fi; \
	)


rust:
	@( \
		if ! command -v cargo &> /dev/null; then \
			curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh; \
		fi \
	)
	@cargo install cargo-watch cargo-audit cargo-asm cargo-license cargo-expand irust;
	@cargo install sqlx-cli --no-default-features --features rustls,mysql,postgres;
	@rustup component add rust-analyzer;

python:
	@python3 -m ensurepip --upgrade;
	@pip3 install python-lsp-server;

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



.PHONY: setup fonts
