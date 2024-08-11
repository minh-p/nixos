{ config, lib, pkgs, ... }:

{
  options.easyeffects.enable = lib.mkEnableOption "enable easyeffects module";
  config = lib.mkIf config.easyeffects.enable {
    services.easyeffects.enable = true;
  };
}
