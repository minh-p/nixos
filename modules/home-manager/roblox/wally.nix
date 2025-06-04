{ lib, stdenv, fetchzip, pkgs }:

stdenv.mkDerivation rec {
  name = "wally";
  src = fetchzip {
    url =
      "https://github.com/UpliftGames/wally/releases/download/v0.3.2/wally-v0.3.2-linux.zip";
    sha256 = "sha256-EdCTWWxwJeTDuICEmtkG20vxLJUI1IrrKcVivFKkLVM=";
  };

  nativeBuildInputs = [ pkgs.autoPatchelfHook ];
  buildInputs = [ stdenv.cc.cc.lib pkgs.zlib pkgs.openssl ];

  installPhase = ''
    mkdir -p $out/bin
    cp -r $src/wally $out/bin
  '';
}
