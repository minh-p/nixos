{ config, lib, pkgs, ... }:

{
  options.mpd.enable = lib.mkEnableOption "enable mpd service";
  config = lib.mkIf config.mpd.enable {
    services.mpd.enable = true;
    services.mpd.musicDirectory = "~/Music";
    programs.ncmpcpp.enable = true;
  };
}
