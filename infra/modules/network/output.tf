output "vpc_id" {
  value = google_compute_network.vpc_network.id
}
output "private-subnet-id" {
  value = google_compute_subnetwork.private_subnet.id
}
output "public-subnet-id" {
  value = google_compute_subnetwork.public_subnet.id
}
#output "net-inf1-id" {
#  value = aws_network_interface.tf-net-inf1.id
#}
#output "net-inf2-id" {
#  value = aws_network_interface.tf-net-inf2.id
#}
#output "internet-gw-id" {
#  value = aws_internet_gateway.internet-gw.id
#}
