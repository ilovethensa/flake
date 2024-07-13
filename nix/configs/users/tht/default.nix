{...}: {
  home-manager = {
    users = {
      # Import your home-manager configuration
      tht = import ../.../../../../../home/tht;
    };
  };
}
