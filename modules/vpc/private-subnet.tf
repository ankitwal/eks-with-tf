resource "aws_subnet" "private" {
  vpc_id     = "${aws_vpc.vpc.id}"
  cidr_block = "${cidrsubnet(aws_vpc.vpc.cidr_block, 8, 1+100)}"

  tags {
    Name    = "${var.project} ${var.availability_zone} private subnet"
    Project = "${var.project}"
  }
}

resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "nat" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id     = "${aws_subnet.public.id}"
  depends_on    = ["aws_internet_gateway.ig"]

  tags = {
    Name    = "${var.project} NAT"
    Project = "${var.project}"
  }
}

resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_route_table_association" "private_table_association" {
  route_table_id = "${aws_route_table.private.id}"
  subnet_id      = "${aws_subnet.private.id}"
}

resource "aws_route" "private_subnet_to_nat_route" {
  route_table_id         = "${aws_route_table.private.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.nat.id}"
}
