{ config, pkgs, pkgs-unstable, lib, inputs, ... }:
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
      spicetifyPackage = pkgs-unstable.spicetify-cli;

      enabledExtensions = with spicePkgs.extensions; [
        fullAppDisplay
        shuffle # shuffle+ (special characters are sanitized out of ext names)
        adblock
        keyboardShortcut
        beautifulLyrics
        hidePodcasts
        history
        volumePercentage
      ];

      enabledCustomApps = with spicePkgs.apps; [
        betterLibrary
        historyInSidebar
        marketplace
      ];
    };
  };
}
