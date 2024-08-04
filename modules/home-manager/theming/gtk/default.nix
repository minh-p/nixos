{ config, lib, pkgs, ... }:
let
  themeName = "Tokyonight-Dark-B-LB";
in {
  options.gtkConfig.enable = lib.mkEnableOption "enable gtkConfig module";
  config = lib.mkIf config.gtkConfig.enable {
    gtk = {
      enable = true;
      theme.package = pkgs.tokyonight-gtk-theme;
      theme.name = themeName;
    };
  };
}
