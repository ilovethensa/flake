{...}: {
  services.snowflake-proxy = {
    enable = true;
    capacity = 10;
  };
}
