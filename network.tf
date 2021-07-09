# SET UP VPC
resource "aws_vpc" "pilot-env" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "pilot-env"
  }
}

resource "aws_eip" "ip-pilot-env" {
  instance = "${aws_instance.pilot-ec2-instance.id}"
  vpc      = true
}