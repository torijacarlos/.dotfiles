SHELL=/bin/bash

OH_MY_ZSH_INSTALL=https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh

DOTFILES_APPS=wofi waybar ghostty zsh nvim tmux bin git systemd

LAPTOP_PACKAGES=brightnessctl

# TODO: iwd vs NetworkManager
SYSTEM_PACKAGES =sysfsutils bluez bluez-utils ufw reflector
SYSTEM_PACKAGES+=man-db man-pages tree

UTIL_PACKAGES =tmux stow fzf ripgrep tig
UTIL_PACKAGES+=ncdu btop nethogs iftop nvtop bottom
UTIL_PACKAGES+=unzip imagemagick pastel

STORAGE_PACKAGES =rsync syncthing borg

HOUSE_PACKAGES =ollama sqlite

DESKTOP_PACKAGES =ghostty waybar wofi hyprlock swaybg grim
DESKTOP_PACKAGES+=wl-clipboard xclip hyprpicker
DESKTOP_PACKAGES+=fcitx5-im fcitx5-anthy dolphin gnome-keyring
DESKTOP_PACKAGES+=qt5-graphicaleffects qt5-quickcontrols2 qt5-svg # used by sddm

DEV_PACKAGES =base base-devel cmake clang llvm clang-tools-extra gdb heaptrack glfw mbedtls
DEV_PACKAGES+=jq raylib lua aws-cli lua-language-server go cmark sdl3_image sdl3_ttf jdk-openjdk

FONT_PACKAGES =ttf-hack-nerd ttf-nerd-fonts-symbols ttf-droid 
FONT_PACKAGES+=noto-fonts noto-fonts-emoji otf-font-awesome otf-ipafont

APP_PACKAGES=chromium krita discord audacity steam libreoffice-fresh freecad

# installed here, never called out: opencode (bluetui: laptop)

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
	@sudo pacman -S $(STORAGE_PACKAGES);
	@sudo pacman -S $(DESKTOP_PACKAGES);
	@sudo pacman -S $(DEV_PACKAGES); 
	@sudo pacman -S $(HOUSE_PACKAGES);
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

ufw-setup:
	@echo "=== UFW";
	@sudo ufw --force enable
	@sudo systemctl enable --now ufw
	@sudo ufw default deny incoming
	@sudo ufw default allow outgoing
	@sudo ufw default disabled routed
	@sudo ufw allow from 192.168.0.0/24 to any port 22 proto tcp comment 'ssh lan'
	@sudo ufw status verbose

vault-setup:
	@echo "=== VAULT TIMERS";
	@systemctl --user daemon-reload
	@systemctl --user enable --now vault-daily.timer vault-weekly.timer
	@systemctl --user list-timers --no-pager | head -5

syncthing-setup:
	@echo "=== SYNCTHING";
	@systemctl --user enable --now syncthing.service
	@sleep 2; \
	key=$$(grep -oE '<apikey>[^<]+' $${HOME}/.local/state/syncthing/config.xml | cut -d'>' -f2); \
	curl -skL -H "X-API-Key: $$key" https://127.0.0.1:8384/rest/config/options | \
	python3 -c "import json,sys; o=json.load(sys.stdin); o['relaysEnabled']=False; o['globalAnnounceEnabled']=False; o['natEnabled']=False; print(json.dumps(o))" | \
	curl -skL -X PUT -H "X-API-Key: $$key" -H "Content-Type: application/json" -d @- https://127.0.0.1:8384/rest/config/options >/dev/null; \
	sudo ufw allow from 192.168.0.0/24 to any port 22000 proto tcp || true; \
	sudo ufw allow from 192.168.0.0/24 to any port 21027 proto udp || true; \
	echo "=== strict posture: relays off, global announce off, nat off, lan-direct only"
	@echo "=== pairing one-human step: GUI https://127.0.0.1:8384, folder ~/kura/media/photos/mobile, receive-only, phone send-only"

structure:
	@echo "=== Structure";
	@mkdir -p ~/kura/code;
	@mkdir -p ~/kura/docs/personal ~/kura/docs/finance;
	@mkdir -p ~/kura/art/pixelart ~/kura/art/digitalart ~/kura/art/drawing ~/kura/art/3d ~/kura/art/reference;
	@mkdir -p ~/kura/media/photos/camera ~/kura/media/photos/mobile ~/kura/media/games ~/kura/media/courses;

sddm-theme:
	@echo "=== SDDM Theme";
	@sudo mkdir /usr/share/sddm/themes/sugar-candy ||:;
	@sudo cp -r ./assets/sugar-candy/ /usr/share/sddm/themes/
	@sudo mkdir /etc/sddm.conf.d ||:;
	@sudo touch /etc/sddm.conf.d/override.conf ||:;
	@sudo cp ./assets/sddm-override.conf /etc/sddm.conf.d/override.conf 
	@sudo cp ./assets/sugar-candy/Backgrounds/lockscreen.png ~/.config/


.PHONY: setup fonts
