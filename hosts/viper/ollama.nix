{...}: {
  services.ollama = {
    enable = true;
    acceleration = "rocm";
    environmentVariables = {
      HCC_AMDGPU_TARGET = "gfx803"; # used to be necessary, but doesn't seem to anymore
      ROC_ENABLE_PRE_VEGA = "1";
    };
    rocmOverrideGfx = "10.3.1";
  };
}
