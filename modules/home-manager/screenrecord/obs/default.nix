{ config, lib, pkgs, ... }:

{
  options.obs.enable = lib.mkEnableOption "enable obs module";
  config = lib.mkIf config.obs.enable {
    programs.obs-studio = {
      enable = true;
      plugins = with pkgs; [
        obs-studio-plugins.wlrobs
        obs-studio-plugins.obs-vaapi
      ];
    };
  };
}
