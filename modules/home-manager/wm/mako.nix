{ lib, config, pkgs, ... }:

{
  options.mako.enable = lib.mkEnableOption "enable mako module";

  config = lib.mkIf config.mako.enable {
    services.mako = {
      enable = true;
      sort = "-time";
      layer = "overlay";
      backgroundColor = "#285577";
      width = 300;
      height = 110;
      borderSize = 2;
      borderColor = "#000000";
      borderRadius = 15;
      icons = true;
      maxIconSize = 64;
      defaultTimeout = 5000;
      ignoreTimeout = true;
      font = "DejaVu Sans Mono 14";
      extraConfig = ''
        [urgency=low]
        border-color=#cccccc

        [urgency=normal]
        border-color=#d08770

        [urgency=high]
        border-color=#bf616a
        default-timeout=0

        [category=mpd]
        default-timeout=2000
        group-by=category
      '';
    };
  };
}
