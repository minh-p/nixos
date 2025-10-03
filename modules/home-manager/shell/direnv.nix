{ config, lib, pkgs, pkgs-unstable, ... }:

{
  options.direnv.enable = lib.mkEnableOption "enable direnv module";
  config = lib.mkIf config.direnv.enable {
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
      nix-direnv.package = pkgs-unstable.nix-direnv;
    };

    zsh.enable = true;
  };
}
