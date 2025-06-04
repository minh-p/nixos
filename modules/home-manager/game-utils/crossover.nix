{ pkgs ? import <nixpkgs> { } }:

pkgs.stdenv.mkDerivation rec {
  pname = "crossover";
  version = "3.3.4";

  src = pkgs.fetchurl {
    url =
      "https://github.com/lacymorrow/crossover/releases/download/v${version}/CrossOver-${version}-amd64.deb";
    sha256 = "sha256-CKDNQw+oVJrIw8AvVSJQH0T6WVK6qeSgBS1hLlASlwM=";
  };

  unpackPhase = ''
    mkdir -p root
    dpkg-deb -x $src root
  '';

  installPhase = ''
    mkdir -p $out
    mkdir $out/bin
    cp -r root/opt/CrossOver $out/
    ln -s $out/CrossOver/crossover $out/bin/crossover
  '';

  nativeBuildInputs = [ pkgs.dpkg ];

  buildInputs = with pkgs; [
    # Electron runtime deps
    glibc
    alsa-lib
    atk
    at-spi2-core
    cairo
    cups
    dbus
    expat
    fontconfig
    freetype
    gdk-pixbuf
    glib
    gtk3
    libdrm
    libnotify
    libuuid
    libxkbcommon
    mesa
    nspr
    nss
    pango
    xorg.libX11
    xorg.libXcomposite
    xorg.libXcursor
    xorg.libXdamage
    xorg.libXext
    xorg.libXi
    xorg.libXrandr
    xorg.libXrender
    xorg.libXtst
    zlib
  ];

  meta = with pkgs.lib; {
    description = "Custom crosshair overlay for any game";
    homepage = "https://github.com/lacymorrow/crossover";
    platforms = platforms.linux;
    license = licenses.mit;
  };
}
