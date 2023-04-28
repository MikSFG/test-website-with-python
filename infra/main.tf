module "network" {
  source = "./modules/network"

  project              = var.project
  region               = var.region
  availability_zones   = var.availability_zones
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
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
      ipv4_enabled = true
      authorized_networks {
        name  = "unsecure"
        value = "0.0.0.0/0"
      }
    }
  }

  deletion_protection  = "false"
}