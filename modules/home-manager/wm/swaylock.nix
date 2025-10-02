{ config, lib, pkgs, ... }:

{
  options.swaylock.enable = lib.mkEnableOption "enable swaylock effects module";
  config = lib.mkIf config.swaylock.enable {
    programs.swaylock = {
      enable = true;
      package = pkgs.swaylock-effects;
      settings = {
        ignore-empty-password = true;
        font = "Ubuntu";

        clock = true;
        timestr = "%R";
        datestr = "%a, %e of %B";

        screenshots = true;

        fade-in = "0.2";

        effect-blur = "30x5";
        # effect-greyscale = true; # uncomment if you want it enabled
        effect-scale = "0.1";
        effect-vignette = "0.5:0.5";

        indicator = true;
        indicator-radius = 100;
        indicator-thickness = 7;
        indicator-caps-lock = true;

        key-hl-color = "2ac3de";

        separator-color = "00000000";

        inside-color = "00000000";
        inside-clear-color = "ffd20400";
        inside-caps-lock-color = "009ddc00";
        inside-ver-color = "d9d8d800";
        inside-wrong-color = "ee2e2400";

        ring-color = "231f20D9";
        ring-clear-color = "231f20D9";
        ring-caps-lock-color = "231f20D9";
        ring-ver-color = "231f20D9";
        ring-wrong-color = "231f20D9";

        line-color = "2ac3de";
        line-clear-color = "ffd204FF";
        line-caps-lock-color = "009ddcFF";
        line-ver-color = "d9d8d8FF";
        line-wrong-color = "ee2e24FF";

        text-clear-color = "ffd20400";
        text-ver-color = "d9d8d800";
        text-wrong-color = "ee2e2400";
        text-color = "ffffff";

        bs-hl-color = "ee2e24FF";
        caps-lock-key-hl-color = "ffd204FF";
        caps-lock-bs-hl-color = "ee2e24FF";
        disable-caps-lock-text = true;
        text-caps-lock-color = "009ddc";

        grace = 2;
      };
    };
  };
}
