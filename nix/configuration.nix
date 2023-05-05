{ config, pkgs, ... }:

{
	imports = [ ./hardware-configuration.nix ];

	boot = {
		loader = {
			systemd-boot = {
				enable = true;
				consoleMode = "max";
				editor = true;
			};
			
			efi.canTouchEfiVariables = true;
    	};

    	kernelPackages = pkgs.linuxPackages_latest;
    	blacklistedKernelModules = [ "uvcvideo" ];
    	extraModprobeConfig = ''
options i915 enable_guc=3
options snd-hda-intel patch=hda-jack-retask.fw,hda-jack-retask.fw,hda-jack-retask.fw,hda-jack-retask.fw
'';
	};

	networking = {
		hostName = "bag";
		networkmanager.enable = true;
	};

	time.timeZone = "Europe/Moscow";

	i18n.defaultLocale = "ru_RU.UTF-8";
	console.font = "cyr-sun16";

	hardware = {
		opengl = {
			enable = true;
			
			driSupport = true;
			driSupport32Bit = true;
			extraPackages = with pkgs; [ intel-media-driver ];
		};

		# pulseaudio = {
			# enable = true;
# 
			# support32Bit = true;
		# };
		firmware = [ (pkgs.writeTextDir "/lib/firmware/hda-jack-retask.fw" ''
[codec]
0x10ec0269 0x10ec11da 0

[pincfg]
0x12 0x90a60130
0x14 0x90170110
0x17 0x40000000
0x18 0x40f000f0
0x19 0x411111f0
0x1a 0x411111f0
0x1b 0x411111f0
0x1d 0x40e69e05
0x1e 0x411111f0
0x21 0x03214020
''
		)];
	};

	nixpkgs.config.allowUnfree = true;

	programs.dconf.enable = true;
	programs.steam.enable = true;
	services.gvfs.enable = true;
	services.openssh.enable = true;
	virtualisation.docker.enable = true;

	programs.adb.enable = true;

	services.pipewire = {
		enable = true;

		alsa.enable = true;
		pulse.enable = true;
	};

	users = {
		users.milk = {
			shell = pkgs.zsh;
			description = "async await";
			isNormalUser = true;
			extraGroups = [ "wheel" "video" "audio" "plugdev" "users" "docker" "netdev" "adbusers" ];
		};

		groups.netdev = {};
	};

	environment.systemPackages = with pkgs; [ ];

	security = {
		doas = {
			enable = true;
			
			extraRules = [ { groups = [ "wheel" ]; keepEnv = true; persist = true; } ];
		};

		pam.services.swaylock = {};

		polkit = {
			enable = true;
			
			extraConfig = ''
polkit.addRule(function(action, subject) {
  if (action.id.indexOf("org.freedesktop.NetworkManager.") == 0 && subject.isInGroup("netdev")) {
    return polkit.Result.YES;
  }
});
'';
		};
	};

	system.stateVersion = "22.11";
}

