# Create PostgreSQL Cluster with hosts in 3 zones
# Link to terraform documentation - https://registry.tfpla.net/providers/yandex-cloud/yandex/latest/docs/resources/mdb_postgresql_cluster

resource "yandex_mdb_postgresql_cluster" "foo" {
  name        = "new-cluster1994"
  environment = "PRODUCTION" //PRESTABLE or PRODUCTION
  network_id  = var.default_network_id

  config {
    version = 12 //version of the cluster
    resources {
      resource_preset_id = "s2.micro" //resource_preset_id - types are in the official documentation
      disk_type_id       = "network-ssd" //disk_type_id - types are in the official documentation
      disk_size          = 16 //disk size
    }
  }

  maintenance_window {
    type = "ANYTIME"
  }

  database {
    name  = "db_name"
    owner = "user_name"
  }

  user {
    name     = "user_name"
    password = "password"
    permission {
      database_name = "db_name"
    }
  }

  host {
    zone      = "ru-central1-a"
    subnet_id = var.default_subnet_id_zone_a
  }

  host {
    zone      = "ru-central1-b"
    subnet_id = var.default_subnet_id_zone_b
  }

  host {
    zone      = "ru-central1-c"
    subnet_id = var.default_subnet_id_zone_c
  }
}
