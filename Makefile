SHELL=/bin/bash

OH_MY_ZSH_INSTALL=https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh
DOTFILES_APPS=wofi waybar alacritty zsh nvim tmux bin git
# NOTE: hypr needs separate handling

LAPTOP_PACKAGES=brightnessctl
SYSTEM_PACKAGES=bluez bluez-utils qt5‑graphicaleffects qt5‑quickcontrols2 qt5‑svg wl-clipboard
# NOTE: hyprpaper seems to lack a lot of features, so keeping swaybg for a sec
UTIL_PACKAGES=fzf ripgrep tig tmux stow man-db man-pages waybar xclip rclone hyprpaper hyprlock swaybg unzip tree scdoc reflector fcitx5-im fcitx5-anthy
DEV_PACKAGES=heaptrack jq cmake gdb clang-tools-extra \
			 raylib sld2 sdl2_image sdl2_mixer sdl2_ttf lua
APP_PACKAGES=krita audacity discord chromium steam blender
FONT_PACKAGES=ttf-hack-nerd otf-font-awesome ttf-nerd-fonts-symbols ttf-droid noto-fonts noto-fonts-emoji otf-ipafont
YAY_PACKAGES=protonup-qt davinci-resolve obs-studio-tytan652

# Installation script should add: git neovim chromium

setup: 
	@echo "Welcome $(shell whoami)!, Let's setup";
	@make base;
	@make zsh-setup;
	@make dotfiles;
	@make tmux-setup;
	@make structure;
	@make yay-setup;
	@make sddm-theme;

# ----------------- #
# Base Setup        #
# ----------------- #

base:
	@echo "=== Base";
	@sudo pacman -Syy;
	@sudo pacman -S $(SYSTEM_PACKAGES);
	@sudo pacman -S $(UTIL_PACKAGES) $(DEV_PACKAGES); 
	@sudo pacman -S $(FONT_PACKAGES) $(APP_PACKAGES);

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
		if command -v stow &> /dev/null; then \
			for folder in $(DOTFILES_APPS); do \
				echo "====== stow $$folder"; \
				stow -D $$folder;\
				stow $$folder; \
			done; \
		fi \
	)
	@stow --adopt hypr;
	@git restore .;

tmux-setup:
	@echo "=== TMUX";
	@( \
		if [ ! -d "$$HOME/.tmux/plugins/tpm" ]; then \
			echo "====== Downloading tpm"; \
			git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm; \
		fi; \
	)

structure:
	@echo "=== Structure";
	@mkdir -p ~/drive;
	@mkdir -p ~/develop/oss;
	@mkdir -p ~/develop/torija;
	@mkdir -p ~/develop/atelier;

sddm-theme:
	@echo "=== SDDM Theme";
	@sudo mkdir /usr/share/sddm/themes/sugar-candy ||:;
	@sudo cp -r ./assets/sugar-candy/ /usr/share/sddm/themes/
	@sudo mkdir /etc/sddm.conf.d ||:;
	@sudo touch /etc/sddm.conf.d/override.conf ||:;
	@sudo cp ./assets/sddm-override.conf /etc/sddm.conf.d/override.conf 
	@sudo cp ./assets/sugar-candy/Backgrounds/lockscreen.png ~/.config/

yay-setup:
	@sudo git clone https://aur.archlinux.org/yay.git ~/yay ||:
	@cd ~/yay
	@makepkg -si

# ----------------- #
# Languages Setup   #
# ----------------- #

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
