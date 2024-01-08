{
  description = "Sittymin's NixOS Flake";






  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    hyprland.url = "github:hyprwm/Hyprland";
    anyrun.url = "github:Kirottu/anyrun";
    anyrun.inputs.nixpkgs.follows = "nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, home-manager, anyrun, ... }@inputs: {
    #homeConfigurations."Sittymin@nixos" = home-manager.lib.homeManagerConfiguration {
    #  pkgs = nixpkgs.legacyPackages.x86_64-linux;

    #  modules = [
    #    hyprland.homeManagerModules.default
    #    {
    #      wayland.windowManager.hyprland.enable = true;
    #    }
    #  ];
    #};
    nixosConfigurations = {
      "nixos" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = { inherit inputs; };

        #system.packages = [anyrun.packages.${system}.anyrun];

        modules = [
          ./configuration.nix
          #./hardware-configuration.nix


          #hyprland.nixosModules.default
          #{programs.hyprland = {
          #  enable = true;
          #  xwayland.enable = true;
          #  };
          #}

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            # 这里的 import 函数在前面 Nix 语法中介绍过了，不再赘述
            home-manager.users.Sittymin = import ./home;

            # 使用 home-manager.extraSpecialArgs 自定义传递给 ./home.nix 的参数
            # 取消注释下面这一行，就可以在 home.nix 中使用 flake 的所有 inputs 参数了
            home-manager.extraSpecialArgs = inputs;
          }
        ];
      };
    };
  };
}
