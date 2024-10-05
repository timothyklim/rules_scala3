_:

with builtins;
let
  flake = getFlake (toString ./.);
in
flake.inputs.nixpkgs.legacyPackages.${currentSystem}
