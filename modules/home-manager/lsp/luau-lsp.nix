{ lib, stdenv, fetchzip, pkgs }:

stdenv.mkDerivation rec {
  name = "luau-lsp";
  src = fetchzip {
    url =
      "https://github.com/JohnnyMorganz/luau-lsp/releases/download/1.46.0/luau-lsp-linux.zip";
    sha256 = "r7JcOYgKyTTq7Cieht0TArP72/H2C7lBjVFBBM5eAn8=";
  };

  nativeBuildInputs = [ pkgs.autoPatchelfHook ];
  buildInputs = [ stdenv.cc.cc.lib ];

  installPhase = ''
    mkdir -p $out/bin
    cp -r $src/luau-lsp $out/bin
  '';
}
