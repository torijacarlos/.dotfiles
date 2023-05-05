SHELL=/bin/bash
OH_MY_ZSH_INSTALL=https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh
DOTFILES_APPS=i3 zsh alacritty polybar picom rofi nvim tmux bin git
MACOS_PACKAGES=
FEDORA_MIRRORS=https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-38.noarch.rpm \
		https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-38.noarch.rpm \
		fedora-workstation-repositories
GLOBAL_PACKAGES=zsh stow fzf neovim ripgrep tig tmux tldr xclip openssl 
FEDORA_PACKAGES=g++ gtk3 webkit2gtk3 libusb rofi nitrogen polybar autorandr playerctl maim i3 \
		picom alacritty arandr pbcopy ImageMagick xdpyinfo \
		docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin nautilus \
		openssl-devel lutris wine steam google-chrome mycli postgresql discord fd-find ffmpeg sqlite
FEDORA_AUDIO=pulseaudio pipewire-pulseaudio alsa-utils alsa-firmware alsa-plugins-pluseaudio


setup: 
	@echo "Welcome $(shell whoami)!, Let's setup";
	@make packages;
	@make zsh-setup;
	@make dotfiles;
	@make tmux-setup;
	@make rust;


packages:
	@sudo dnf -y update;
	@sudo dnf install -y dnf-plugins-core;
	@sudo dnf config-manager --set-enabled google-chrome;
	@sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo;
	@sudo dnf install -y $(FEDORA_MIRRORS);
	@sudo dnf install -y $(GLOBAL_PACKAGES) $(FEDORA_PACKAGES);
	@sudo dnf install -y $(FEDORA_AUDIO) --allowerasing;
	@sudo dnf swap wireplumpler pipewire-media-session
	@gsettings set org.gnome.desktop.interface color-scheme prefer-dark;


zsh-setup: 
	@echo "=== ZSH";
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
			echo "====== stow sddm"; \
			sudo stow -D sddm -t /etc/sddm.conf.d; \
			sudo stow sddm -t /etc/sddm.conf.d; \
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
	@cargo install cargo-watch cargo-audit cargo-asm cargo-license;
	@cargo install sqlx-cli --no-default-features --features rustls,mysql,postgres;
	@sudo dnf install -y rust-analyzer;


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


pkg-mac:
	@brew install $(GLOBAL_PACKAGES) $(MACOS_PACKAGES);


.PHONY: setup fonts
