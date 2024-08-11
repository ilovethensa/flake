{inputs, ...}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];
  programs.nixvim = {
    enable = true;
    globals.mapleader = ","; # Sets the leader key to comma
    keymaps = [
          {
        key = ";";
        action = ":";
      }
      {
        mode = "n";
        key = "<leader>e";
        #options.silent = true;
        action = "<cmd>Neotree";
      }
    ];

    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavour = "mocha";
        no_bold = false;
        no_italic = false;
        no_underline = false;
        transparent_background = true;
        integrations = {
          cmp = true;
          noice = true;
          notify = true;
          neotree = true;
          harpoon = true;
          gitsigns = true;
          which_key = true;
          illuminate.enabled = true;
          treesitter = true;
          treesitter_context = true;
          telescope.enabled = true;
          indent_blankline.enabled = true;
          mini.enabled = true;
          native_lsp = {
            enabled = true;
            inlay_hints = {
              background = true;
            };
            underlines = {
              errors = ["underline"];
              hints = ["underline"];
              information = ["underline"];
              warnings = ["underline"];
            };
          };
        };
      };
    };
    plugins = {
      persistence.enable = true;
      lightline.enable = true;
      nvim-autopairs.enable = true;
      bufferline.enable = true;

      # Make `nvim .` look prettier
      oil.enable = true;

      # Includes all parsers for treesitter
      treesitter.enable = true;

      # Auto-tagging
      ts-autotag.enable = true;
      # Linting
      lint = {
        enable = true;
        lintersByFt = {
          text = ["vale"];
          json = ["jsonlint"];
          markdown = ["vale"];
          rst = ["vale"];
          ruby = ["ruby"];
          janet = ["janet"];
          inko = ["inko"];
          clojure = ["clj-kondo"];
          dockerfile = ["hadolint"];
          terraform = ["tflint"];
        };
      };
      # Easily toggle comments
      commentary.enable = true;
      # Terminal inside Neovim
      toggleterm = {
        enable = true;
        settings = {
          hide_numbers = false;
          autochdir = true;
          close_on_exit = true;
          direction = "vertical";
        };
      };
      # Prettier fancier command window
      noice = {
        enable = true;
      };

      # Good old Telescope
      telescope = {
        enable = true;
        extensions = {
          fzf-native = {
            enable = true;
          };
        };
      };

      # Todo comments
      todo-comments = {
        enable = true;
        colors = {
          error = ["DiagnosticError" "ErrorMsg" "#DC2626"];
          warning = ["DiagnosticWarn" "WarningMsg" "#FBBF24"];
          info = ["DiagnosticInfo" "#2563EB"];
          hint = ["DiagnosticHint" "#10B981"];
          default = ["Identifier" "#7C3AED"];
          test = ["Identifier" "#FF00FF"];
        };
      };

      # File tree
      neo-tree = {
        enable = true;
        enableDiagnostics = true;
        enableGitStatus = true;
        enableModifiedMarkers = true;
        enableRefreshOnWrite = true;
        closeIfLastWindow = true;
        popupBorderStyle = "rounded"; # Type: null or one of “NC”, “double”, “none”, “rounded”, “shadow”, “single”, “solid” or raw lua code
        buffers = {
          bindToCwd = false;
          followCurrentFile = {
            enabled = true;
          };
        };
        window = {
          width = 40;
          height = 15;
          autoExpandWidth = false;
          mappings = {
            "<space>" = "none";
          };
        };
      };

      undotree = {
        enable = true;
        settings = {
          autoOpenDiff = true;
          focusOnToggle = true;
        };
      };
      lsp = {
        enable = true;
        servers = {
          # Average webdev LSPs
          tsserver.enable = true; # TS/JS
          cssls.enable = true; # CSS
          tailwindcss.enable = true; # TailwindCSS
          html.enable = true; # HTML
          #astro.enable = true; # AstroJS
          phpactor.enable = true; # PHP
          svelte.enable = false; # Svelte
          vuels.enable = false; # Vue
          pyright.enable = true; # Python
          marksman.enable = true; # Markdown
          nil-ls.enable = true; # Nix
          dockerls.enable = true; # Docker
          bashls.enable = true; # Bash
          clangd.enable = true; # C/C++
          csharp-ls.enable = true; # C#
          yamlls.enable = true; # YAML

          lua-ls = {
            # Lua
            enable = true;
            settings.telemetry.enable = false;
          };

          # Rust
          rust-analyzer = {
            enable = true;
            installRustc = true;
            installCargo = true;
          };
        };
      };

      # Dashboard
      alpha = {
        enable = true;
        theme = "dashboard";
        iconsEnabled = true;
      };
    };
  };
}
