{ config, lib, pkgs, ... }:
let
  themeName = "Tokyonight-Dark-B-LB";
in {
  options.gtkConfig.enable = lib.mkEnableOption "enable gtkConfig module";
  config = lib.mkIf config.gtkConfig.enable {
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
    gtk = {
      enable = true;
      theme.package = pkgs.tokyonight-gtk-theme;
      theme.name = themeName;
    };
  };
}
