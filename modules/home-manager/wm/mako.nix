{ lib, config, pkgs, ... }:

{
  options.mako.enable = lib.mkEnableOption "enable mako module";

  config = lib.mkIf config.mako.enable {
    services.mako = {
      enable = true;
      sort = "-time";
      layer = "overlay";
      backgroundColor = "#1a1b26";
      width = 300;
      height = 110;
      borderSize = 2;
      borderColor = "#c0caf5";
      progressColor = "over #302D41";
      textColor = "#c0caf5";
      borderRadius = 15;
      icons = true;
      maxIconSize = 64;
      defaultTimeout = 5000;
      ignoreTimeout = true;
      font = "DejaVu Sans Mono 14";
      extraConfig = ''
        [category=mpd]
        default-timeout=2000
        group-by=category
      '';
    };
  };
}
