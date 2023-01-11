{
  description = "System configuration";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable"; 
#https://jdisaacs.com/blog/nixos-config/
  #  home-manager = {
  #     url = "github:nix-community/home-manager";
  #     inputs.nixpkgs.follows = "nixpkgs";
  #   };
  };
 outputs = { self, nixpkgs }: {
    # replace 'joes-desktop' with your hostname here.
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./configuration.nix ];
    };
  };
}
