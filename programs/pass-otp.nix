# install with:
#    nix-env -i -f /path/to/pass-otp.nix
# Installs passwordstore with otp plugin, and wayland clipboard support

with import <nixpkgs> {};

(pkgs.pass.override { xclip = (import ./wl-clip-x11.nix); }).withExtensions (e: [ e.pass-otp ])
