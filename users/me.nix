{ config, lib, pkgs, ...}:

{
	users.users.me = {
		isNormalUser = true;
		extraGroups = [
			"wheel"
			"networkmanager"
			"input"
			"video"
			"libvirtd"
		];
		subUidRanges = [
			{ count = 65534; startUid = 100000; }
		];
	};
}
