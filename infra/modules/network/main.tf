resource "google_compute_network" "vpc_network" {
  name = "website-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "private_subnet" {
  name          = "website-private-subnet"
  ip_cidr_range = var.private_subnet_cidr
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_subnetwork" "public_subnet" {
  name          = "website-public-subnet"
  ip_cidr_range = var.public_subnet_cidr
  region        = var.region
  network       = google_compute_network.vpc_network.id
}



#resource "aws_internet_gateway" "internet-gw" {
#  vpc_id = aws_vpc.vpc1.id
#
#  tags = {
#    Name = "${var.project}-internet-gw"
#  }
#}
#
#resource "aws_eip" "nat_eip" {
#  vpc        = true
#  depends_on = [aws_internet_gateway.internet-gw]
#}
#
#resource "aws_nat_gateway" "nat" {
#  allocation_id = aws_eip.nat_eip.id
#  subnet_id     = aws_subnet.pub_subnet.id
#  depends_on    = [aws_internet_gateway.internet-gw]
#
#  tags = {
#    Name        = "${var.project}-nat"
#  }
#}
#
#resource "aws_network_interface" "tf-net-inf1" {
#  subnet_id = aws_subnet.pub_subnet.id
#  private_ips = ["10.0.1.111"]
#
#  tags = {
#    Name = "${var.project}-net-inf1"
#  }
#}
#
#resource "aws_network_interface" "tf-net-inf2" {
#  subnet_id = aws_subnet.priv_subnet.id
#  private_ips = ["10.0.2.111"]
#
#  tags = {
#    Name = "${var.project}-net-inf2"
#  }
#}
#
#resource "aws_route_table" "route_table_pub" {
#  vpc_id = aws_vpc.vpc1.id
#
#  route {
#    cidr_block = "0.0.0.0/0"
#    gateway_id = aws_internet_gateway.internet-gw.id
#  }
#
#  tags = {
#    Name = "${var.project}-pub-route-table"
#  }
#}
#
#resource "aws_route_table" "route_table_priv" {
#  vpc_id = aws_vpc.vpc1.id
#
#  route {
#    cidr_block = "0.0.0.0/0"
#    nat_gateway_id = aws_nat_gateway.nat.id
#  }
#
#  tags = {
#    Name = "${var.project}-priv-route-table"
#  }
#}
#
#resource "aws_route_table_association" "pub_rta" {
#  subnet_id      = aws_subnet.pub_subnet.id
#  route_table_id = aws_route_table.route_table_pub.id
#}
#
#resource "aws_route_table_association" "priv_rta" {
#  subnet_id      = aws_subnet.priv_subnet.id
#  route_table_id = aws_route_table.route_table_priv.id
#}
#
#resource "aws_default_security_group" "forbid_all" {
#  vpc_id      = aws_vpc.vpc1.id
#  depends_on  = [aws_vpc.vpc1]
#  tags = {
#    Name = "${var.project}-default-sc"
#  }
#}
#
#resource "aws_vpc_security_group_ingress_rule" "disable_6443_port" {
#  security_group_id = aws_default_security_group.forbid_all.id
#
#  cidr_ipv4   = "0.0.0.0/0"
#  from_port   = 22
#  ip_protocol = "tcp"
#  to_port     = 22
#}

#resource "aws_vpc_security_group_egress_rule" "example" {
#  security_group_id = aws_default_security_group.forbid_all.id
#
#  cidr_ipv4   = "0.0.0.0/0"
#  ip_protocol = "-1"
#}