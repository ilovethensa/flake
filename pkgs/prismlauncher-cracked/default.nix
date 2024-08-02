{
  lib,
  stdenv,
  fetchFromGitHub,
  stripJavaArchivesHook,
  cmake,
  cmark,
  ninja,
  jdk8,
  jdk17,
  jdk21,
  zlib,
  qtbase,
  quazip,
  extra-cmake-modules,
  tomlplusplus,
  ghc_filesystem,
  gamemode,
  qt5,
  msaClientID ? null,
  wrapQtAppsHook,
  xorg,
  libpulseaudio,
  libGL,
  glfw,
  openal,
  vulkan-loader,
  udev,
  libusb1,
  flite,
  gamemodeSupport ? stdenv.isLinux,
  textToSpeechSupport ? stdenv.isLinux,
  controllerSupport ? stdenv.isLinux,
  # Adds `glfw-wayland-minecraft` to `LD_LIBRARY_PATH`
  # when launched on wayland, allowing for the game to be run natively.
  # Make sure to enable "Use system installation of GLFW" in instance settings
  # for this to take effect
  #
  # Warning: This build of glfw may be unstable, and the launcher
  # itself can take slightly longer to start
  withWaylandGLFW ? false,
  jdks ? [jdk21 jdk17 jdk8],
  additionalLibs ? [],
  additionalPrograms ? [],
  glxinfo,
  pciutils,
  addOpenGLRunpath,
}: let
  libnbtplusplus = fetchFromGitHub {
    owner = "PrismLauncher";
    repo = "libnbtplusplus";
    rev = "a5e8fd52b8bf4ab5d5bcc042b2a247867589985f";
    hash = "sha256-A5kTgICnx+Qdq3Fir/bKTfdTt/T1NQP2SC+nhN1ENug=";
  };
in
  assert lib.assertMsg (stdenv.isLinux || !gamemodeSupport) "gamemodeSupport is only available on Linux";
    stdenv.mkDerivation (finalAttrs: {
      pname = "prismlauncher-cracked";
      version = "v8.4.1";
      src = fetchFromGitHub {
        owner = "Diegiwg";
        repo = "PrismLauncher-Cracked";
        rev = finalAttrs.version;
        hash = "sha256-ffx3MgvKj9VsRIK9DT5Cxr+3WSrvMglzLE+kFU/cni4=";
      };

      nativeBuildInputs = [extra-cmake-modules cmake jdk17 ninja stripJavaArchivesHook qt5.qtnetworkauth wrapQtAppsHook];
      buildInputs =
        [
          qtbase
          zlib
          quazip
          ghc_filesystem
          tomlplusplus
          cmark
        ]
        ++ lib.optional gamemodeSupport gamemode;
      #++ lib.optionals stdenv.isDarwin [Cocoa];

      hardeningEnable = lib.optionals stdenv.isLinux ["pie"];

      cmakeFlags =
        [
          # downstream branding
          "-DLauncher_BUILD_PLATFORM=nixpkgs"
        ]
        ++ lib.optionals (msaClientID != null) ["-DLauncher_MSA_CLIENT_ID=${msaClientID}"]
        ++ lib.optionals (lib.versionOlder qtbase.version "6") ["-DLauncher_QT_VERSION_MAJOR=5"]
        ++ lib.optionals stdenv.isDarwin [
          "-DINSTALL_BUNDLE=nodeps"
          "-DMACOSX_SPARKLE_UPDATE_FEED_URL=''"
          "-DCMAKE_INSTALL_PREFIX=${placeholder "out"}/Applications/"
        ];

      postUnpack = ''
        rm -rf source/libraries/libnbtplusplus
        ln -s ${libnbtplusplus} source/libraries/libnbtplusplus
      '';

      dontWrapQtApps = false;
      qtWrapperArgs = let
        runtimeLibs =
          [
            xorg.libX11
            xorg.libXext
            xorg.libXcursor
            xorg.libXrandr
            xorg.libXxf86vm

            # lwjgl
            libpulseaudio
            libGL
            glfw
            openal
            stdenv.cc.cc.lib
            vulkan-loader # VulkanMod's lwjgl

            # oshi
            udev
          ]
          ++ lib.optional gamemodeSupport gamemode.lib
          ++ lib.optional textToSpeechSupport flite
          ++ lib.optional controllerSupport libusb1
          ++ additionalLibs;

        runtimePrograms =
          [
            xorg.xrandr
            glxinfo
            pciutils # need lspci
          ]
          ++ additionalPrograms;
      in
        ["--prefix PRISMLAUNCHER_JAVA_PATHS : ${lib.makeSearchPath "bin/java" jdks}"]
        ++ lib.optionals stdenv.isLinux [
          "--set LD_LIBRARY_PATH ${addOpenGLRunpath.driverLink}/lib:${lib.makeLibraryPath runtimeLibs}"
          # xorg.xrandr needed for LWJGL [2.9.2, 3) https://github.com/LWJGL/lwjgl/issues/128
          "--prefix PATH : ${lib.makeBinPath runtimePrograms}"
        ];

      meta = {
        mainProgram = "prismlauncher";
        homepage = "https://prismlauncher.org/";
        description = "A free, open source launcher for Minecraft";
        longDescription = ''
          Allows you to have multiple, separate instances of Minecraft (each with
          their own mods, texture packs, saves, etc) and helps you manage them and
          their associated options with a simple interface.
        '';
        platforms = with lib.platforms; linux ++ darwin;
        changelog = "https://github.com/PrismLauncher/PrismLauncher/releases/tag/${finalAttrs.version}";
        license = lib.licenses.gpl3Only;
        maintainers = with lib.maintainers; [minion3665 Scrumplex getchoo];
      };
    })
