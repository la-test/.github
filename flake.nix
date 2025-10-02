{
  inputs = {
    # The nixpkgs channels we want to consume
    nixpkgs-25_05.url = "github:NixOS/nixpkgs/nixos-25.05";

    # Some links to the above channels for consistent naming in outputs
    nixpkgs.follows = "nixpkgs-25_05";

    # Extra inputs for modules leaving outside nixpkgs
    flake-compat = {
      url = "https://flakehub.com/f/edolstra/flake-compat/1.tar.gz";
    };
  };
  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      devShells."${system}".default = pkgs.mkShell {
        packages = with pkgs; [
          docker-compose
        ];
      };
    };
}
