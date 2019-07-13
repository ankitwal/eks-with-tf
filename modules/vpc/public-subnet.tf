resource "aws_subnet" "public" {
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${cidrsubnet(aws_vpc.vpc.cidr_block, 4, 1)}"
  availability_zone = "${var.availability_zone}"

  tags {
    Name    = "${var.project} ${var.availability_zone} public subnet"
    Project = "${var.project}"
  }
}

#Associate subnet with vpc routable
resource "aws_route_table_association" "public" {
  subnet_id      = "${aws_subnet.public.id}"
  route_table_id = "${aws_route_table.public.id}"
}

#Direct internet bound traffic through IG.
resource "aws_route" "internet_route" {
  route_table_id         = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.ig.id}"
}


