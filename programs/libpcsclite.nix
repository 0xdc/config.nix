# Copy this file to:
#   ~/.config/nixpkgs/config.nix
# and install with: $ nix-env -i libpcsc
# This symlinks the pcsclite libraries into your .nix-profile
# Allows gnupg's scdaemon to use the latest pcsc-driver
{
	nixpkgs.config.packageOverrides = pkgs: with pkgs; {
		libpcsc = pkgs.buildEnv {
			name = "libpcsc";
			paths = [ pcsclite ];
			pathsToLink = [ "/lib" ];
			extraOutputsToInstall = [ "out" ];
		};
	};
}
