{ config, lib, pkgs, inputs, ... }:

{
  stylix.enable = true;
  stylix.image = /etc/nixos/shared/Images/Gate.jpg;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
  stylix.cursor.package = pkgs.bibata-cursors;
  stylix.cursor.name = "Bibata-Modern-Ice";
  stylix.cursor.size = 24;
  stylix.opacity = {
    applications = 1.0;
    terminal = 0.9;
    desktop = 1.0;
    popups = 1.0;
  };
  stylix.polarity = "dark";
}
