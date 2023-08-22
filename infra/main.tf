module "network" {
  source = "./modules/network"

  project              = var.project
  region               = var.region
  availability_zones   = var.availability_zones
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
}

resource "google_project_service" "vpcaccess_api" {
  project = var.project
  service = "vpcaccess.googleapis.com"
}

resource "google_vpc_access_connector" "vpc_connector" {
  name          = "vpc-connector"
  project       = var.project
  region        = var.region
  network       = module.network.vpc_id
  ip_cidr_range = "10.132.0.0/28"
  depends_on = [
    google_project_service.vpcaccess_api
  ]
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
    vpc_access {
      # Use the VPC Connector
      connector = google_vpc_access_connector.vpc_connector.id
      # all egress from the service should go through the VPC Connector
      egress = "ALL_TRAFFIC"
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
#  provisioner "local-exec" {
#    command = "PGPASSWORD=<password> psql -f schema.sql -p <port> -U <username> <databasename>"
#  }
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