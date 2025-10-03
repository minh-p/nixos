{ lib, config, pkgs, ... }:

{
  options = { zsh.enable = lib.mkEnableOption "enable zsh module"; };

  config = lib.mkIf config.zsh.enable {
    programs.starship = {
      enable = true;
      settings = {
        battery = {
          full_symbol = "🔋";
          charging_symbol = "🔌";
          discharging_symbol = "⚡";
          display = [{
            threshold = 30;
            style = "bold red";
          }];
        };
        character.error_symbol = "[✖](bold red) ";
        cmd_duration.format = " took [$duration]($style)";
        directory = {
          truncation_length = 5;
          format = "[$path]($style)[$lock_symbol]($lock_style) ";
          style = "bold dimmed blue";
        };

        git_branch = {
          format = " [$symbol$branch]($style) ";
          symbol = "🍣 ";
          style = "bold yellow";
        };

        git_commit = {
          commit_hash_length = 8;
          style = "bold white";
        };

        git_state.format =
          "[($state( $progress_current of $progress_total))]($style) ";

        git_status = {
          conflicted = "⚔️ ";
          ahead = "🏎️ 💨 ×$count";
          behind = "🐢 ×$count";
          diverged = "🔱 🏎️ 💨 ×$ahead_count 🐢 ×$behind_count";
          untracked = "🛤️  ×$count";
          stashed = "📦 ";
          modified = "📝 ×$count";
          staged = "🗃️  ×$count";
          renamed = "📛 ×$count";
          deleted = "🗑️  ×$count";
          style = "bright-white";
          format = "$all_status$ahead_behind";
        };

        hostname = {
          ssh_only = false;
          format = "<[$hostname]($style)>";
          trim_at = "-";
          style = "bold dimmed white";
          disabled = true;
        };

        julia = {
          format = "[$symbol$version]($style) ";
          symbol = "ஃ ";
          style = "bold green";
        };

        memory_usage = {
          format = "$symbol[$ram( | $swap)]($style) ";
          threshold = 70;
          style = "bold dimmed white";
          disabled = false;
        };

        package.disabled = true;

        python = {
          format = "[$symbol$version]($style) ";
          style = "bold green";
        };

        rust = {
          format = "[$symbol$version]($style) ";
          style = "bold green";
        };

        time = {
          time_format = "%T";
          format = "🕙 $time($style) ";
          style = "bright-white";
          disabled = false;
        };

        username = {
          style_user = "bold dimmed blue";
          show_always = true;
        };
      };
    };
    programs.zsh = {
      enable = true;
      shellAliases = {
        config = "git --git-dir=$HOME/dotfiles/ --work-tree=$HOME";
        wifi = "nmtui";
        ls = "ls --color=auto";
        tmux = "tmux -u";
      };
      initExtra = lib.mkMerge [
        ''
          if [[ $TERM != "dumb" ]]; then
            eval "$(${config.home.profileDirectory}/bin/starship init zsh)"
          fi
        ''

        (lib.mkIf config.direnv.enable ''
          eval "$(direnv hook zsh)"
        '')
      ];
    };
  };
}
