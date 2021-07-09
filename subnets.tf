# SET UP SUBNET
resource "aws_subnet" "subnet-uno" {
  cidr_block = "${cidrsubnet(aws_vpc.pilot-env.cidr_block, 3, 1)}"
  vpc_id = "${aws_vpc.pilot-env.id}"
  availability_zone = "us-east-2a"
  map_public_ip_on_launch = true
}

resource "aws_route_table" "route-table-pilot-env" {
  vpc_id = "${aws_vpc.pilot-env.id}"
route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.pilot-env-gw.id}"
  }
tags = {
    Name = "pilot-env-route-table"
  }
}
resource "aws_route_table_association" "subnet-association" {
  subnet_id      = "${aws_subnet.subnet-uno.id}"
  route_table_id = "${aws_route_table.route-table-pilot-env.id}"
}