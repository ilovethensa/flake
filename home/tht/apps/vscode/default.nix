{pkgs, ...}: {
  # Configure Visual Studio Code
  programs.vscode = {
    enable = true;
    package = pkgs.vscode; #.fhsWithPackages (ps: with ps; [rustup zlib openssl.dev pkg-config clippy]);
    mutableExtensionsDir = false;
    # Define extensions to be installed
    extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      usernamehw.errorlens
      eamodio.gitlens
      jdinhlife.gruvbox
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons
      christian-kohler.path-intellisense
      rust-lang.rust-analyzer
      github.vscode-pull-request-github
      vscode-icons-team.vscode-icons
      aaron-bond.better-comments
      kamadorueda.alejandra
      ms-python.python
      ms-python.vscode-pylance
      continue.continue
      astro-build.astro-vscode
    ];

    # Define user settings for Visual Studio Code
    userSettings = {
      "workbench.colorTheme" = "Catppuccin Mocha";
      "workbench.iconTheme" = "catppuccin-mocha";
      "files.autoSave" = "afterDelay";
      "editor.bracketPairColorization.independentColorPoolPerBracketType" = true;
      "editor.formatOnPaste" = true;
      "editor.formatOnSave" = true;
      "editor.formatOnType" = true;
      "notebook.formatOnSave.enabled" = true;
      "notebook.formatOnCellExecution" = true;
      "rust-analyzer.checkOnSave.command" = "clippy";
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "${pkgs.nil}/bin/nil";
    };
  };
}
