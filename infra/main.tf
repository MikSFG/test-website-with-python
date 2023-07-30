module "network" {
  source = "./modules/network"

  project              = var.project
  region               = var.region
  availability_zones   = var.availability_zones
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
}

resource "google_compute_instance" "front_instance" {
  machine_type = "e2-micro-"
  name         = "front-instance"
  zone         = var.availability_zones[0]
  network_interface {
    network = module.network.vpc_id
    subnetwork = module.network.public-subnet-id
    access_config {
    }
  }
  boot_disk {
    initialize_params {
      image = var.front_image
    }
  }
  metadata = {
    role = "front"
  }
}

resource "google_sql_database" "sql_db" {
  name     = "website-db"
  instance = google_sql_database_instance.sql_db_instance.name
  project = var.project
  charset = "utf8mb4"
}

resource "google_sql_database_instance" "sql_db_instance" {
  name             = "website-db-instance"
  region           = var.region
  project          = var.project
  database_version = "MYSQL_8_0"
  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled    = false
      private_network = module.network.vpc_id
    }
  }
  deletion_protection  = "false"
}

resource "google_sql_user" "temp_sql_user" {
  name     = "root"
  instance = google_sql_database_instance.sql_db_instance.name
  password = "changeme"
}