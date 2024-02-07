{ config, pkgs, Neve, ... }:

{

  imports = [
    ./fcitx5
    ./waybar
    ./firefox
    ./anyrun
    ./minecraft
    ./shell
  ];

  # 注意修改这里的用户名与用户目录
  home.username = "Sittymin";
  home.homeDirectory = "/home/Sittymin";

  # 直接将当前文件夹的配置文件，链接到 Home 目录下的指定位置
  home.file = {
    ".config/hypr/hyprland.conf".source = ./hyprland/hyprland.conf;
    ".config/mako/config".source = ./mako/config;
    ".config/cheat".source = ./cheat;
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
  # 设置GTK颜色偏好为暗色
  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };


  # 设置鼠标指针大小以及字体 DPI（适用于 2K 显示器）
  #  xresources.properties = {
  #
  #    "Xcursor.size" = 24;
  #    "Xft.dpi" = 120;
  #  };



  # 通过 home.packages 安装一些常用的软件
  # 这些软件将仅在当前用户下可用，不会影响系统级别的配置
  # 建议将所有 GUI 软件，以及与 OS 关系不大的 CLI 软件，都通过 home.packages 安装
  home.packages = with pkgs;[
    neofetch # 显示系统信息的工具，如操作系统、内核版本、CPU、内存等。
    mpv
    libjxl
    # 基于libvips的图片浏览器
    # vipsdisp
    # Qt图片加载库（JXL）
    libsForQt5.kimageformats
    # 基于Qt的图片浏览器
    qview
    # 基于 Nixvim 配置的 Neovim 的 Neve
    Neve.packages."${pkgs.system}".default
    # vim复制到系统剪贴
    wl-clipboard
    # archives
    zip # 压缩为zip
    unzip # 解压zip
    xz # xz
    p7zip # 7z
    zstd # zstd
    unrar # rar

    # GUI文件管理器
    cinnamon.nemo

    # JDK
    graalvm-ce
    # nodejs
    bun
    nodejs_21

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
    # 通知程序
    mako

    # SSH 
    termius
    #wine
    wineWowPackages.stagingFull
    steam
    qq
    telegram-desktop
    # 适用于Hyprland 的截图软件
    hyprshot
    # 命令行备忘录
    cheat
  ];
  programs = {
    git = {
      enable = true;
      userName = "Sittymin";
      userEmail = "wu2890108976@gmail.com";
    };
    # 一个自动补全工具
    carapace.enable = true;
    carapace.enableNushellIntegration = true;


    kitty = {
      enable = true;
      theme = "Catppuccin-Mocha";
      font = {
        name = "MonaspiceNe NFM";
        size = 12;
      };
      settings = {
        tab_bar_edge = "top";
        background_opacity = "0.5";
        # 模糊需要在Hyprland
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
