{ lib, config, pkgs, ... }:

{
  options.polkit-kde-authentication-agent.enable = lib.mkEnableOption "enable kde authentication module";
  config = lib.mkIf config.polkit-kde-authentication-agent.enable {
    home.packages = with pkgs; [
      kdePackages.polkit-kde-agent-1
    ];
    systemd = {
      user.services.polkit-kde-authentication-agent-1 = {
        Unit = {
          Description = "polkit-kde-authentication-agent-1";
        };
        Install = {
          WantedBy = [ "graphical-session.target" ];
          Wants = [ "graphical-session.target" ];
          After = [ "graphical-session.target" ];
        };
        Service = {
          Type = "simple";
          ExecStart = "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
      };
    };
  };
}
