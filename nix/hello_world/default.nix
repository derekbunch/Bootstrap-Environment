let
  pkgs = import <nixpkgs> { };
in 
{
  hello = pkgs.callPackage ./hello_world.nix {};
  icat = pkgs.callPackage ./icat.nix { };
}
