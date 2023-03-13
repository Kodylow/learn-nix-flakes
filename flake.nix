{
  description = "A flake for building Hello World";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: {

    defaultPackage.x86_64-linux =
      with import nixpkgs { system = "x86_64-linux"; };
      stdenv.mkDerivation {
        name = "hello";
        src = self;
        buildPhase = "gcc -o hello ./hello.c";
        installPhase = "mkdir -p $out/bin; install -t $out/bin hello";
      };

    devShell.x86_64-linux = 
      let pkgs = import nixpkgs { system = "x86_64-linux"; }; in
      pkgs.mkShell {
        name = "hello-dev";
        buildInputs = [ pkgs.gcc ];
      };

    packages.x86_64-linux =
      with import nixpkgs { system = "x86_64-linux"; };
      {
        hello = defaultPackage.x86_64-linux;
      };

    defaultPackage.aarch64-linux =
      with import nixpkgs { system = "aarch64-linux"; };
      stdenv.mkDerivation {
        name = "hello";
        src = self;
        buildPhase = "gcc -o hello ./hello.c";
        installPhase = "mkdir -p $out/bin; install -t $out/bin hello";
      };

    devShell.aarch64-linux = 
      let pkgs = import nixpkgs { system = "aarch64-linux"; }; in
      pkgs.mkShell {
        name = "hello-dev";
        buildInputs = [ pkgs.gcc ];
      };

    packages.aarch64-linux =
      with import nixpkgs { system = "aarch64-linux"; };
      {
        hello = defaultPackage.aarch64-linux;
      };

    defaultPackage.aarch64-darwin =
      with import nixpkgs { system = "aarch64-darwin"; };
      stdenv.mkDerivation {
        name = "hello";
        src = self;
        buildPhase = "clang -o hello ./hello.c";
        installPhase = "mkdir -p $out/bin; install -t $out/bin hello";
      };

    devShell.aarch64-darwin = 
      let pkgs = import nixpkgs { system = "aarch64-darwin"; }; in
      pkgs.mkShell {
        name = "hello-dev";
        buildInputs = [ pkgs.clang ];
      };

    packages.aarch64-darwin =
      with import nixpkgs { system = "aarch64-darwin"; };
      {
        hello = defaultPackage.aarch64-darwin;
      };
  };
}
