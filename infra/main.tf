module "network" {
  source = "./modules/network"

  project              = var.project
  region               = var.region
  availability_zones   = var.availability_zones
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
}

resource "google_cloud_run_v2_service" "cloud_run_frontend" {
  name     = "frontend"
  location = var.region
  ingress = "INGRESS_TRAFFIC_ALL"

  template {
    containers {
      image = var.frontend_image
    }
  }
}

resource "google_cloud_run_service_iam_binding" "cloud_run_frontend_iam" {
  service  = google_cloud_run_v2_service.cloud_run_frontend.name
  location = google_cloud_run_v2_service.cloud_run_frontend.location
  role     = "roles/run.invoker"
  members = [
    "allUsers"
  ]
}

resource "google_cloud_run_v2_service" "cloud_run_backend" {
  name     = "backend"
  location = var.region
  ingress = "INGRESS_TRAFFIC_ALL"

  template {
    containers {
      image = var.backend_image
    }
  }
}

resource "google_cloud_run_service_iam_binding" "cloud_run_backend_iam" {
  service  = google_cloud_run_v2_service.cloud_run_backend.name
  location = google_cloud_run_v2_service.cloud_run_backend.location
  role     = "roles/run.invoker"
  members = [
    "allUsers"
  ]
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
  depends_on = [module.network.private_vpc_connection_id]
  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled    = false
      private_network = module.network.vpc_id
      enable_private_path_for_google_cloud_services = true
    }
  }
  deletion_protection  = "false"
}

resource "google_sql_user" "temp_sql_user" {
  name     = "root"
  instance = google_sql_database_instance.sql_db_instance.name
  password = "changeme"
}