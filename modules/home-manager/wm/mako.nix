{ lib, config, pkgs, ... }:

{
  options.mako.enable = lib.mkEnableOption "enable mako module";

  config = lib.mkIf config.mako.enable {
    services.mako = {
      enable = true;
      settings = {
        sort = "-time";
        layer = "overlay";
        background-color = "#1a1b26";
        width = 300;
        height = 110;
        border-size = 2;
        border-color = "#c0caf5";
        progress-color = "over #302D41";
        text-color = "#c0caf5";
        border-radius = 15;
        icons = true;
        max-icon-size = 64;
        default-timeout = 5000;
        ignore-timeout = true;
        font = "DejaVu Sans Mono 14";
      };
    };
  };
}
