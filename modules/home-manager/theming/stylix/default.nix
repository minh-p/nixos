{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.stylix.enable {
    stylix.targets = {
      sway.enable = false;
      emacs.enable = false;
      mako.enable = false;
      firefox.enable = false;
    };
  };
}
