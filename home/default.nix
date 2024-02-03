{ config, pkgs, Neve, ... }:

{

  imports = [
    ./fcitx5
    ./waybar
    ./firefox
    ./anyrun
    ./minecraft
  ];

  # 注意修改这里的用户名与用户目录
  home.username = "Sittymin";
  home.homeDirectory = "/home/Sittymin";

  # 直接将当前文件夹的配置文件，链接到 Home 目录下的指定位置
  home.file = {
    ".config/hypr/hyprland.conf".source = ./hyprland/hyprland.conf;
    ".config/yazi" = {
      source = ./yazi;
      recursive = true;
      executable = true;
    };
    ".config/mpv" = {
      source = ./mpv;
      recursive = true;
    };
  };

  # 递归将某个文件夹中的文件，链接到 Home 目录下的指定位置
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # 递归整个文件夹
  #   executable = true;  # 将其中所有文件添加「执行」权限
  # };

  # 直接以 text 的方式，在 nix 配置文件中硬编码文件内容
  # home.file.".xxx".text = ''
  #     xxx
  # '';




  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };
  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Pink";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "pink" ];
        tweaks = [ "rimless" "black" ];
        variant = "mocha";
      };
    };
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
  };

  # 环境变量设置
  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    GDK_BACKEND = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
  };


  # 设置鼠标指针大小以及字体 DPI（适用于 2K 显示器）
  #  xresources.properties = {
  #
  #    "Xcursor.size" = 24;
  #    "Xft.dpi" = 120;
  #  };

  # git 相关配置
  programs = {
    git = {
      enable = true;
      userName = "Sittymin";
      userEmail = "wu2890108976@gmail.com";
    };
    #anyrun = {
    #  enable = true;
    #};
  };

  # 通过 home.packages 安装一些常用的软件
  # 这些软件将仅在当前用户下可用，不会影响系统级别的配置
  # 建议将所有 GUI 软件，以及与 OS 关系不大的 CLI 软件，都通过 home.packages 安装
  home.packages = with pkgs;[
    neofetch # 显示系统信息的工具，如操作系统、内核版本、CPU、内存等。
    mpv
    qview
    # 基于 Nixvim 配置的 Neovim 的 Neve
    Neve.packages."${pkgs.system}".default
    # archives
    zip
    xz
    unzip
    p7zip

    # JDK
    graalvm-ce

    # 与Nix相关的工具，提供更详细的日志输出。
    nix-output-monitor

    glow # markdown previewer in terminal

    btop # 系统和网络监控工具
    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # 用于调节音频设备的软件
    helvum

    # 桌面环境相关
    waybar # 一个漂亮的状态栏

    steam
    qq
    telegram-desktop
    # 适用于Hyprland 的截图软件
    hyprshot
  ];
  programs = {
    nushell = {
      enable = true;
    };

    # 一个自动补全工具
    carapace.enable = true;
    carapace.enableNushellIntegration = true;

    # 启用 starship，这是一个漂亮的 shell 提示符
    starship = {
      enable = true;
      enableNushellIntegration = true;
      settings = {
        # add_newline = true;
        character = {
          success_symbol = "[›](bold green)";
          error_symbol = "[›](bold red)";
        };
        format = "[░▒▓](#a3aed2)[  ](bg:#a3aed2 fg:#090c0c)[](bg:#769ff0 fg:#a3aed2)$directory[](fg:#769ff0 bg:#394260)$git_branch$git_status[](fg:#394260 bg:#212736)$nodejs$rust$golang[](fg:#212736 bg:#1d2230)$time[ ](fg:#1d2230)\n$character";
        directory = {
          style = "fg:#e3e5e5 bg:#769ff0";
          format = "[ $path ]($style)";
          truncation_length = 3;
          truncation_symbol = "…/";
        };
        directory.substitutions = {
          "Documents" = "󰈙 ";
          "Downloads" = " ";
          "Music" = " ";
          "Pictures" = " ";
        };
        git_branch = {
          symbol = "";
          style = "bg:#394260";
          format = "[[ $symbol $branch ](fg:#769ff0 bg:#394260)]($style)";
        };
        git_status = {
          style = "bg:#394260";
          format = "[[($all_status$ahead_behind )](fg:#769ff0 bg:#394260)]($style)";
        };
        nodejs = {
          symbol = "";
          style = "bg:#212736";
          format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
        };
        rust = {
          symbol = "";
          style = "bg:#212736";
          format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
        };
        golang = {
          symbol = "";
          style = "bg:#212736";
          format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
        };
        time = {
          disabled = false;
          time_format = "%R"; # Hour:Minute Format
          style = "bg:#1d2230";
          format = "[[  $time ](fg:#a0a9cb bg:#1d2230)]($style)";
        };
      };
    };

    kitty = {
      enable = true;
      theme = "Catppuccin-Mocha";
      font = {
        name = "MonaspiceNe NFM";
        size = 12;
      };
      settings = {
        tab_bar_edge = "top";
      };

    };
    yazi = {
      enable = true;
      enableNushellIntegration = true;
    };
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
