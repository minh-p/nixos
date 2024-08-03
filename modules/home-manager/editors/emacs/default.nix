{ config, lib, pkgs, inputs, ... }:

let
  setup-doom-emacs = pkgs.writeShellScriptBin "setup-doom-emacs" ''
    if [ -e ~/.config/doom/init.el ]; then
      # maybe a dumb idea
      cd ~/.config/doom
      git pull origin main
    else
      mkdir -p ~/.config/doom
      cd ~/.config/doom
      git init
      git remote add origin ${config.emacs.doomConfig.url}
      git remote set-url --push ${config.emacs.doomConfig.pullRemote}
      git fetch --depth 1 origin main
      git reset --hard origin/main
    fi
    if [ -e ~/.config/emacs/bin/doom ]; then
      cd ~/.config/emacs
      git pull origin master
      ~/.config/emacs/bin/doom sync --force
    else
       mkdir -p ~/.config/emacs
       cd ~/.config/emacs
       git init
       git remote add origin https://github.com/doomemacs/doomemacs
       git fetch --depth 1 origin master
       git reset --hard origin/master
      ~/.config/emacs/bin/doom sync
    fi
  '';
in {
  options.emacs.enable = lib.mkEnableOption "enable emacs module";
  options.emacs.doomConfig.url = lib.mkOption {
    type = lib.types.str;
    default = "git@github.com:minh-p/doom-emacs-config.git";
  };
  options.emacs.doomConfig.pullRemote = lib.mkOption {
    type = lib.types.str;
    default = "main";
  };
  config = lib.mkIf config.emacs.enable {
    home.packages = [
      setup-doom-emacs
    ];
    systemd.user.services."setup-doom-emacs" = {
      Unit = {
        Description = "configure doom emacs";
        After = [ "network-online.target" ];
        PartOf = [ "graphical-session.target" ];
      };
      Install = { WantedBy = [ "graphical-session.target" ]; };
      Service = {
        ExecStart = "${setup-doom-emacs}/bin/setup-doom-emacs";
        Type = "oneshot";
        Restart = "failed";
      };
    };
    home.activation = {
      setup-doom-emacs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        $DRY_RUN_CMD systemctl --user restart setup-doom-emacs &
      '';
    };
    programs.emacs.enable = true;
    programs.emacs.package = pkgs.emacs29-pgtk;
    services.emacs.enable = true;
  };
}
