{ config, lib, pkgs, ... }:

{
  options = { foot.enable = lib.mkEnableOption "enable foot module (zsh)"; };
  config = lib.mkIf config.foot.enable {
    programs.foot = {
      enable = true;

      # If you're on a Home Manager version that supports these,
      # keep them; otherwise just rely on settings below.
      # server.enable = true;

      settings = {
        main = { shell = "zsh"; };

        key-bindings = { "show-urls-launch" = "Control+Mod1+u"; };
      };
    };
  };
}
