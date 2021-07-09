resource "aws_internet_gateway" "pilot-env-gw" {
  vpc_id = "${aws_vpc.pilot-env.id}"
tags = {
    Name = "pilot-env-gw"
  }
}