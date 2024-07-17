{...}: {
  virtualisation.oci-containers.containers = {
    bitmagnet = {
      autoStart = true;
      image = "ghcr.io/bitmagnet-io/bitmagnet:latest";
      ports = [
        "3333:3333"
        "3334:3334/tcp"
        "3334:3334/udp"
      ];
      environment = {
        POSTGRES_HOST = "bitmagnet-postgres";
        POSTGRES_PASSWORD = "postgres";
      };
      cmd = [
        "worker"
        "run"
        "--keys=http_server"
        "--keys=queue_server"
        "--keys=dht_crawler"
      ];
      dependsOn = ["bitmagnet-postgres"];
    };
    bitmagnet-postgres = {
      autoStart = true;
      image = "postgres:16-alpine";
      volumes = [
        "/mnt/data/postgres:/var/lib/postgresql/data"
      ];
      environment = {
        POSTGRES_PASSWORD = "postgres";
        POSTGRES_DB = "bitmagnet";
        PGUSER = "postgres";
      };
    };
  };
}
