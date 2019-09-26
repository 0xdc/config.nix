with import <nixpkgs> {};

stdenv.mkDerivation rec {
	pname = "wl-clipboard-x11";
	version = "4";

	src = fetchFromGitHub {
		owner = "brunelli";
		repo = "wl-clipboard-x11";
		rev = "v${version}";
		sha256 = "1sx3k2852crxhdyga40xgjbs52gpx87lfxq54amg7wjvp8qycnyp";
	};

	buildInputs = [ wl-clipboard ];
	installFlags = [ "PREFIX=$(out)" ];
	dontBuild = true;
}
