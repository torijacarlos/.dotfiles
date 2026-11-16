SHELL=/bin/bash

OH_MY_ZSH_INSTALL=https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh

DOTFILES_APPS=wofi waybar ghostty zsh nvim tmux bin git

LAPTOP_PACKAGES=brightnessctl

# TODO: iwd vs NetworkManager
SYSTEM_PACKAGES =sysfsutils bluez bluez-utils wl-clipboard 
SYSTEM_PACKAGES+=qt5‑graphicaleffects qt5‑quickcontrols2 qt5‑svg # used by sddm

UTIL_PACKAGES =fzf ripgrep tig tmux stow man-db man-pages ghostty imagemagick
UTIL_PACKAGES+=ncdu btop iftop nvtop bottom reflector 
UTIL_PACKAGES+=xclip rclone hyprlock swaybg waybar wofi dolphin
UTIL_PACKAGES+=unzip tree fcitx5-im fcitx5-anthy grim
UTIL_PACKAGES+=pastel hyprpicker freecad gnome-keyring rsync 

DEV_PACKAGES =base base-devel cmake clang llvm clang-tools-extra gdb heaptrack glfw mbedtls
DEV_PACKAGES+=jq raylib lua aws-cli lua-language-server go cmark sdl3_image sdl3_ttf jdk-openjdk

FONT_PACKAGES =ttf-hack-nerd ttf-nerd-fonts-symbols ttf-droid 
FONT_PACKAGES+=noto-fonts noto-fonts-emoji otf-font-awesome otf-ipafont

APP_PACKAGES=chromium krita discord audacity steam

# installed here, never called out: ollama opencode ufw sqlite (bluetui: laptop)

YAY_PACKAGES =orca-slicer-bin minecraft-launcher grimblast-git
#YAY_PACKAGES+=protonup-qt davinci-resolve obs-studio-tytan652 darktable neofetch

# Installation script should add: git neovim

setup: 
	@echo "Welcome $(shell whoami)!, Let's setup";
	@make base;
	@make zsh-setup;
	@make dotfiles;
	@make tmux-setup;
	@make structure;
	@make sddm-theme;

# ----------------- #
# Base Setup        #
# ----------------- #

base:
	@echo "=== Base";
	@sudo pacman -Syy;
	@sudo pacman -S $(SYSTEM_PACKAGES);
	@sudo pacman -S $(UTIL_PACKAGES); 
	@sudo pacman -S $(DEV_PACKAGES); 
	@sudo pacman -S $(FONT_PACKAGES);
	@sudo pacman -S $(APP_PACKAGES);

zsh-setup: 
	@echo "=== ZSH";
	@sudo pacman -S zsh;
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
		if ! command -v stow &> /dev/null; then \
			echo "====== Installing stow"; \
			sudo pacman -S stow; \
		fi; \
		for folder in $(DOTFILES_APPS); do \
			echo "====== stow $$folder"; \
			stow -D $$folder;\
			stow $$folder; \
		done; \
		stow --adopt hypr; \
		git restore hypr; \
	)

tmux-setup:
	@echo "=== TMUX";
	@( \
		if [ ! -d "$$HOME/.tmux/plugins/tpm" ]; then \
			echo "====== Downloading tpm"; \
			git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm; \
		fi; \
	)
	@echo "====== Installing plugins"
	@~/.tmux/plugins/tpm/scripts/install_plugins.sh

structure:
	@echo "=== Structure";
	@mkdir -p ~/drive;
	@mkdir -p ~/develop/oss;
	@mkdir -p ~/develop/torija;

sddm-theme:
	@echo "=== SDDM Theme";
	@sudo mkdir /usr/share/sddm/themes/sugar-candy ||:;
	@sudo cp -r ./assets/sugar-candy/ /usr/share/sddm/themes/
	@sudo mkdir /etc/sddm.conf.d ||:;
	@sudo touch /etc/sddm.conf.d/override.conf ||:;
	@sudo cp ./assets/sddm-override.conf /etc/sddm.conf.d/override.conf 
	@sudo cp ./assets/sugar-candy/Backgrounds/lockscreen.png ~/.config/


.PHONY: setup fonts
