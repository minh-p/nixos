{ config, lib, pkgs, ... }:

let
  start-cliphist = pkgs.writeShellScriptBin "start-cliphist" ''
    wl-paste --watch cliphist store &
  '';

in {
  home.packages = with pkgs; [
    start-cliphist
  ];
}
