{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.stylix.enable {
    stylix.targets = {
      gtk.enable = true;
      kde.enable = true;
      foot.enable = true;
      waybar.enable = true;
    };
    stylix.fonts.sizes = {
      desktop = 11;
    };
  };
}
