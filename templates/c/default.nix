{
  lib,
  llvmPackages_18,
  gnumake,
}:
llvmPackages_18.stdenv.mkDerivation {
  pname = "cpp-examples";
  version = "0.1.0";

  src = ./.;

  nativeBuildInputs = [gnumake];
  buildInputs = [];

  installPhase = ''
    mkdir -p $out/bin
    cp build/clol $out/bin
  '';

  meta = with lib; {
    homepage = "https://github.com/nixvital/nix-based-cpp-starterkit";
    description = ''
      A template for Nix based C++ project setup.";
    '';
    licencse = licenses.mit;
    platforms = with platforms; linux ++ darwin;
    maintainers = [maintainers.breakds];
  };
}
