{ config, lib, pkgs, ... }:

{
	boot.loader.systemd-boot.enable = true;
	boot.initrd.luks.devices.crypted.device = "/dev/disk/by-uuid/14591a8f-7b8a-453b-b9df-2e7ad3ffce71";

	boot.initrd.preLVMCommands =
		''
		echo 18 | tee /sys/devices/system/cpu/intel_pstate/max_perf_pct
		echo  1 | tee /sys/devices/system/cpu/intel_pstate/no_turbo
		echo  1 | tee /sys/class/leds/chromeos::kbd_backlight/brightness
		'';

	boot.initrd.availableKernelModules = [
		"cros_kbd_led_backlight"
	];
	networking = {
		hostName = "samus";
		networkmanager.enable = true;
		dhcpcd.enable = false;
	};

	system.stateVersion = "19.03";
	sound.enable = true;

	hardware = {
		brightnessctl.enable = true;
		bluetooth.enable = true;
		pulseaudio.enable = true;
	};
}
