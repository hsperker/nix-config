{ pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [
      pkgs.home-manager
    ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  environment.darwinConfig = "$HOME/src/github.com/hsperker/nix-config/darwin";

  # Auto upgrade nix package and the daemon service.
  nix.enable = false;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs = {
    gnupg.agent.enable = true;
    fish.enable = true;
  };

  users = {
    knownUsers = [ ${user} ];
    users.${user}.uid = 501;
    users.${user}.shell = pkgs.fish;
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  fonts.packages = [
    pkgs.atkinson-hyperlegible
    pkgs.jetbrains-mono
  ];

  services = {
    aerospace = {
      enable = true;
      settings = {
        accordion-padding = 0;
        on-focused-monitor-changed = [ "move-mouse monitor-lazy-center" ];
        on-window-detected = [
        ];
        workspace-to-monitor-force-assignment = {
          "1" = ["main"];
          "2" = ["secondary" "main"];
        };
        mode = {
          main = {
            binding = {
              alt-y = "layout tiles horizontal vertical";
              alt-t = "layout accordion horizontal vertical";
              alt-h = "focus left";
              alt-j = "focus down";
              alt-k = "focus up";
              alt-l = "focus right";
              alt-shift-h = "move left";
              alt-shift-j = "move down";
              alt-shift-k = "move up";
              alt-shift-l = "move right";
              alt-ctrl-h = "join-with left";
              alt-ctrl-j = "join-with down";
              alt-ctrl-k = "join-with up";
              alt-ctrl-l = "join-with right";
              alt-minus = "resize smart -100";
              alt-equal = "resize smart +100";
              alt-1 = "workspace 1";
              alt-2 = "workspace 2";
              alt-3 = "workspace 3";
              alt-shift-1 = "move-node-to-workspace 1";
              alt-shift-2 = "move-node-to-workspace 2";
              alt-shift-3 = "move-node-to-workspace 3";
              alt-tab = "workspace-back-and-forth";
              alt-shift-tab = "move-node-to-monitor --wrap-around next";
              alt-shift-semicolon = "mode service";
            };
          };
          service = {
            binding = {
              esc = [ "reload-config" "mode main" ];
              r = [ "flatten-workspace-tree" "mode main" ];
              f = [ "layout floating tiling" "mode main" ];
              backspace = [ "close-all-windows-but-current" "mode main" ];
            };
          };
        };
      };
    };
    jankyborders = {
      enable = true;
      blur_radius = 5.0;
      hidpi = true;
      active_color = "0xAAB279A7";
      inactive_color = "0x33867A74";
    };
  };

  homebrew = {
    enable = true;

    onActivation.autoUpdate  = true;
    onActivation.upgrade = true;

    # Install apps that are free
    casks = [
      "1password"
      "alfred"
      "homerow"
      "chatgpt"
    ];

    # Install apps I payed for
    masApps = {
    };
  };

  # unlock sudo via fingerprint
  security.pam.services.sudo_local.touchIdAuth = true;

  power.restartAfterFreeze = true;

  system = {
    defaults = {
      NSGlobalDomain = {
        # Expand save panel by default
        NSNavPanelExpandedStateForSaveMode = true;
        # Expand print panel by default
        PMPrintingExpandedStateForPrint = true;
        # Save to disk (not to iCloud) by default
        NSDocumentSaveNewDocumentsToCloud = false;
        # Disable smart quotes as they’re annoying when typing code
        NSAutomaticQuoteSubstitutionEnabled = false;
        # Disable smart dashes as they’re annoying when typing code
        NSAutomaticDashSubstitutionEnabled = false;
        # Disable press-and-hold for keys in favor of key repeat
        ApplePressAndHoldEnabled = false;
        # Set a blazingly fast keyboard repeat rate, and make it happen more quickly.
        InitialKeyRepeat = 20;
        KeyRepeat = 1;
        # Disable auto-correct
        NSAutomaticSpellingCorrectionEnabled = false;
        # Finder: show hidden files by default
        AppleShowAllFiles = true;
        AppleShowAllExtensions = true;
        # Enable spring loading for directories
        "com.apple.springing.enabled" = true;
        # Remove the spring loading delay for directories
        "com.apple.springing.delay" = 0.1;
      };

      trackpad = {
        # Trackpad: Haptic feedback (light, silent clicking)
        FirstClickThreshold = 0;
        ActuationStrength = 0;
        # Trackpad: map bottom right corner to right-click
        TrackpadRightClick = true;
      };

      dock = {
        autohide = true;
        mru-spaces = false;
        autohide-time-modifier = 0.0;
        tilesize = 30;
        expose-animation-duration = 0.15;
        showhidden = true;
        
        # disable hot corners
        wvous-br-corner = 1;
        wvous-tr-corner = 1;
        wvous-bl-corner = 1;
      };          

      finder = {
        AppleShowAllExtensions = true;
        FXPreferredViewStyle = "clmv";
        NewWindowTarget = "Home";
        ShowStatusBar = true;
        _FXShowPosixPathInTitle = true;
        FXDefaultSearchScope = "SCcf";
        FXEnableExtensionChangeWarning = false;
        _FXSortFoldersFirst = true;
      };

      screencapture = {
        location = "~/Pictures/screenshots";
        disable-shadow = true;
        type = "png";
      };
      
      ActivityMonitor = {
        OpenMainWindow = true;
        ShowCategory = 100;
      };

      CustomSystemPreferences = {
        NSGlobalDomain = {
          WebKitDeveloperExtras = true;
        };
        "com.apple.Safari" = {
          "IncludeDevelopMenu" = true;
          "WebKitDeveloperExtrasEnabledPreferenceKey" = true;
          "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" = true;
        };
        "com.apple.print.PrintingPrefs" = {
          "Quit When Finished" = true;
        };
        "com.apple.desktopservices" = {
          "DSDontWriteNetworkStores" = true;
        };
        "com.apple.mail" = {
          "AddressesIncludeNameOnPasteboard" = false;
        };
        "com.apple.messageshelper.MessageController" = {
          "SOInputLineSettings" = {
            "automaticQuoteSubstitutionEnabled" = false;
            "continuousSpellCheckingEnabled" = false;
          };
        }; 
        "com.apple.appstore" = {
          "InAppReviewEnabled" = 0;
        };
        "com.apple.finder" = {
          "QLEnableTextSelection" = true;
        }; 
      };
    };
  };
}
