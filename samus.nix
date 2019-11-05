{ config, lib, pkgs, ... }:

{
	boot.loader.systemd-boot.enable = true;
	boot.initrd.luks.devices.crypted.device = "/dev/disk/by-uuid/14591a8f-7b8a-453b-b9df-2e7ad3ffce71";

	boot.initrd.preLVMCommands =
		''
		echo     18 | tee /sys/devices/system/cpu/intel_pstate/max_perf_pct
		echo      1 | tee /sys/devices/system/cpu/intel_pstate/no_turbo
		echo      1 | tee /sys/class/leds/chromeos::kbd_backlight/brightness
		echo 500000 | tee /sys/devices/system/cpu/cpufreq/policy?/scaling_max_freq
		'';

	boot.initrd.availableKernelModules = [
		"cros_kbd_led_backlight"
	];
	networking = {
		hostName = "samus";
		networkmanager.enable = true;
		dhcpcd.enable = false;
	};

	system.stateVersion = "19.09";
	sound.enable = true;

	hardware = {
		brightnessctl.enable = true;
		bluetooth.enable = true;
		pulseaudio = {
			enable = true;
			package = pkgs.pulseaudioFull;
			support32Bit = true;
		};
		opengl.driSupport32Bit = true;
	};

	virtualisation = {
		kvmgt = {
			enable = true;
			device = "0000:00:02.0";
			vgpus = {
				"i915-GVTg_V4_8" = { uuid = "067d7f22-ffc7-11e9-bfb6-0380a078d6c1"; };
			};
		};
		libvirtd = {
			enable = true;
		};
	};

	security.pam.loginLimits = [
	# https://github.com/NixOS/nixos/issues/293#issuecomment-234194392
	# https://wiki.archlinux.org/index.php/Intel_GVT-g#Windows_hanging_with_bad_memory_error
	{
		domain = "@libvirtd";
		type = "-"; # hard and soft limits
		item = "memlock";
		value = "8388608";
	}
	];
}
