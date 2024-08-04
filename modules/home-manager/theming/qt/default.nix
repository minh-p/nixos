{ config, lib, pkgs, ... }:

{
  options.qtConfig.enable = lib.mkEnableOption "enable qtConfig module";
  config = lib.mkIf config.qtConfig.enable {
    qt = {
      enable = true;
      platformTheme.name = "adwaita";
      style.name = "adwaita-dark";
    };
  };
}
