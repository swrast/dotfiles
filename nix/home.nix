{ config, pkgs, ... }:

{
	home.username = "milk";
	home.homeDirectory = "/home/milk";
	fonts.fontconfig.enable = true;

	nixpkgs.config.allowUnfree = true;
	home.packages = 
		let unstable = import <nixpkgs-unstable> { config = { allowUnfree = true; }; };
		in with unstable; [
		(nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
		
		(vscode-with-extensions.override {
			vscode = vscodium;
				vscodeExtensions = with vscode-extensions; [
					ms-python.python
					ms-ceintl.vscode-language-pack-ru
				];
			})
		] ++ (with pkgs; [
			neofetch micro curl htop libarchive catdocx vulkan-tools glxinfo alsa-utils pulseaudio
			inetutils xdg-utils polkit_gnome unrar

			firefox-wayland transmission-gtk mpv
			xfce.thunar xfce.tumbler
			(lutris-free.override { extraPkgs = pkgs: [ pango libnghttp2 ]; })
			gimp kdenlive
			
			swaylock-effects swayidle swaybg imv foot sway-contrib.grimshot mako brightnessctl wlsunset playerctl wl-clipboard
			wf-recorder waybar wl-color-picker
			xwayland xorg.xrandr xorg.xeyes xdg-desktop-portal-wlr xdg-desktop-portal-gtk

			iosevka-bin noto-fonts noto-fonts-emoji noto-fonts-cjk cantarell-fonts

			imagemagick6 python3 python3Packages.pip python3Packages.virtualenv nodejs-18_x yarn ngrok

			xonotic dejavu_fonts
		]
	);
	
	xdg = {
		configFile = {
			"sway/config".source = pkgs.lib.mkForce ./dotfiles/config/sway/config;
			"foot/foot.ini".source = ./dotfiles/config/foot/foot.ini;
			"waybar/config".source = ./dotfiles/config/waybar/config;
			"waybar/style.css".source = ./dotfiles/config/waybar/style.css;
			"sway/wall.png".source = ./dotfiles/pictures/wall.png;
			"sway/battery".source = ./dotfiles/config/sway/battery;
			"sway/lock".source = ./dotfiles/config/sway/lock;
			"sway/wf".source = ./dotfiles/config/sway/wf;
			"mako/config".source = ./dotfiles/config/mako/config;
		};
		userDirs = {
			enable = true;

			desktop = "${config.home.homeDirectory}/desktop";
			documents = "${config.home.homeDirectory}/documents";
			download = "${config.home.homeDirectory}/downloads";
			music = "${config.home.homeDirectory}/music";
			pictures = "${config.home.homeDirectory}/pictures";
			publicShare = "${config.home.homeDirectory}/public";
			templates = "${config.home.homeDirectory}/templates";
			videos = "${config.home.homeDirectory}/videos";
		};
		desktopEntries = {
			micro = { name = "Micro"; noDisplay = true; exec = "micro %F"; };
			thunar-bulk-rename = { name = "Bulk Rename"; noDisplay = true; exec = "thunar --bulk-rename %F"; };
			thunar-settings = { name = "File Manager Settings"; noDisplay = true; exec = "thunar-settings"; };
			mpv = { name = "mpv Media Player"; noDisplay = true; exec = "mpv --player-operation-mode=pseudo-gui -- %U"; };
			foot-server = { name = "Foot Server"; noDisplay = true; exec = "foot --server"; };
			footclient = { name = "Foot Client"; noDisplay = true; exec = "footclient"; };
			htop = { name = "Htop"; noDisplay = true; exec = "htop"; };
			nixos-manual = { name = "NixOS Manual"; noDisplay = true; exec = "nixos-help"; };
			rofi = { name = "Rofi"; noDisplay = true; exec = "rofi -show"; };
			rofi-theme-selector = { name = "Rofi Theme Selector"; noDisplay = true; exec = "rofi-theme-selector"; };
		};
		# portal = {
			# enable = true;
			# extraPortals = with pkgs; [
				# xdg-desktop-portal-wlr
				# xdg-desktop-portal-gtk
			# ];
		# };
	};

	gtk = {
		enable = true;

		iconTheme = {
			name = "Papirus-Dark";
			package = pkgs.papirus-icon-theme;
		};
		theme = {
			name = "Materia-dark";
			package = pkgs.materia-theme;
		};
		cursorTheme = {
			name = "Adwaita";
			package = pkgs.gnome.adwaita-icon-theme;
		};
		font = {
			name = "Liberation Sans 12";
			package = pkgs.liberation_ttf;
		};
		gtk3.extraConfig = {
			Settings = ''

gtk-decoration-layout = menu:
'';
		};
		gtk4.extraConfig = {
			Settings = ''

gtk-application-prefer-dark-theme = 1
gtk-decoration-layout = menu:
'';
		};
	};
	dconf.settings = {
		"org/gnome/desktop/interface" = {
			color-scheme = "prefer-dark";
		};
		"org/gnome/desktop/wm/preferences" = {
			button-layout = "menu:";	
		};
	};
	wayland.windowManager.sway = {
		enable = true;
		wrapperFeatures.gtk = true;
	};

	programs.zsh = {
		enable = true;

		loginExtra = ''
export SDL_VIDEODRIVER=wayland
export QT_QPA_PLATFORM="xcb;wayland"
export QT_SCALE_FACTOR=1.2
export MOZ_ENABLE_WAYLAND=1
export NIXOS_OZONE_WL=y

[ "$(tty)" = "/dev/tty1" ] && exec sway
'';
		oh-my-zsh = {
			enable = true;
			theme = "gentoo";
		};

		enableSyntaxHighlighting = true;
		enableCompletion = true;
		historySubstringSearch.enable = true;
		enableAutosuggestions = true;
	};

	programs.rofi = {
		enable = true;
		package = pkgs.rofi-wayland;

		font = "Liberation Sans 12";
		terminal = "footclient";

		theme = ./dotfiles/config/rofi.css;
		extraConfig = {
			show-icons = true;
		};
	};
	programs.git = {
		enable = true;

		userName = "_";
		userEmail = "___";
	};
	programs.obs-studio = {
		enable = false;

		plugins = with pkgs; [
			obs-studio-plugins.wlrobs
		];
	};

	home.pointerCursor = {
		package = pkgs.gnome.adwaita-icon-theme;
		name = "Adwaita";
	};

	home.stateVersion = "22.11";

	programs.home-manager.enable = true;
}
