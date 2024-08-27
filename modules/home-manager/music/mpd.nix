{ config, lib, pkgs, ... }:

{
  options.mpd.enable = lib.mkEnableOption "enable mpd service";
  config = lib.mkIf config.mpd.enable {
    services.mpd.enable = true;
    services.mpd.musicDirectory = "~/Music";
    services.mpd = {
      dataDir = /home + "/${config.home.username}" + /.config/mpd;
      dbFile = "~/.config/mpd/mpd.db";
    };
    services.mpd.extraConfig = ''
      auto_update                "yes"
      restore_paused             "yes"

      log_file                   "syslog"
      pid_file                   "/tmp/mpd.pid"
      state_file                 "~/.config/mpd/mpd.state"

      audio_output {
          type                   "pipewire"
          name                   "PipeWire Sound Server"
      }

      audio_output {
          type                   "fifo"
          name                   "Visualizer"
          format                 "44100:16:2"
          path                   "/tmp/mpd.fifo"
      }

      audio_output {
        type           "httpd"
        name           "lossless"
        encoder        "flac"
        port           "8000"
        max_clients     "8"
        mixer_type     "software"
        format         "44100:16:2"
      }
    '';
    programs.ncmpcpp.enable = true;
    programs.ncmpcpp.package = pkgs.ncmpcpp.override {
      visualizerSupport = true;
    };
    programs.ncmpcpp.settings = {
      visualizer_data_source = "/tmp/mpd.fifo";
      visualizer_output_name = "my_fifo";
      visualizer_in_stereo = "yes";
      visualizer_type = "wave";
      visualizer_look = "+|";
    };
  };
}
