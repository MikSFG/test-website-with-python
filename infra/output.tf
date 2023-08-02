output "sql_private_ip" {
  value = google_sql_database_instance.sql_db_instance.private_ip_address
}

output "frontend_cloud_run_uri" {
  value = google_cloud_run_v2_service.cloud_run_frontend.uri
}
output "backend_cloud_run_uri" {
  value = google_cloud_run_v2_service.cloud_run_backend.uri
}