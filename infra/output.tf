output "sql_private_ip" {
  value = google_sql_database_instance.sql_db_instance.private_ip_address
}