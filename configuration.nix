{ config, pkgs, ... }:

{
	imports =
		[
			./hardware-configuration.nix
			./samus.nix
			./users/me.nix
		];

	hardware = {
		u2f.enable = true;
	};

	i18n = {
		consoleKeyMap = "uk";
		defaultLocale = "en_GB.UTF-8";
	};

	time.timeZone = "Europe/London";

	programs = {
		gnupg.agent = {
			enable = true;
			enableSSHSupport = true;
		};
		sway = {
			enable = true;
			extraPackages = with pkgs; [
				swayidle
				swaylock
				xwayland
			];
		};
		# FIXME: `sudo nixos-rebuild edit` still uses nano
		vim.defaultEditor = true;
	};

	services = {
		pcscd.enable = true;
		dbus.socketActivated = true;
	};
}
