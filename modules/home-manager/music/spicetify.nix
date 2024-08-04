{ config, pkgs, lib, inputs, ... }:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
{
  # import the flake's module for your system
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];

  options = {
    spicetify.enable = lib.mkEnableOption "enable spicetify flake";
  };

  config = lib.mkIf config.spicetify.enable {
    programs.spicetify = {
      enable = true;
      theme = spicePkgs.themes.catppuccin;
      colorScheme = "macchiato";
      windowManagerPatch = true;

      enabledExtensions = with spicePkgs.extensions; [
        fullAppDisplay
        shuffle # shuffle+ (special characters are sanitized out of ext names)
        hidePodcasts
        adblock
        keyboardShortcut
      ];

      enabledCustomApps = with spicePkgs.apps; [
        marketplace
      ];
    };
  };
}
