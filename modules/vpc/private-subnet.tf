resource "aws_subnet" "private" {
  count             = var.az_count
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${cidrsubnet(aws_vpc.vpc.cidr_block, 6, count.index+1)}"
  availability_zone = "${var.availability_zones[count.index]}"
  tags = {
    Name    = "${var.project} ${var.availability_zones[count.index]} private subnet"
    Project = "${var.project}"
  }
}

resource "aws_eip" "nat" {
  count = var.az_count
  vpc   = true
}

resource "aws_nat_gateway" "nat" {
  count         = var.az_count
  allocation_id = "${aws_eip.nat.*.id[count.index]}"
  subnet_id     = "${aws_subnet.public.*.id[count.index]}"
  depends_on    = ["aws_internet_gateway.ig"]

  tags = {
    Name    = "${var.project} ${var.availability_zones[count.index]} NAT"
    Project = "${var.project}"
  }
}

resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_route_table_association" "private_table_association" {
  count          = var.az_count
  route_table_id = "${aws_route_table.private.id}"
  subnet_id      = "${aws_subnet.private.*.id[count.index]}"
}

resource "aws_route" "private_subnet_to_nat_route" {
  count                  = var.az_count
  route_table_id         = "${aws_route_table.private.*.id[count.index]}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.nat.*.id[count.index]}"
}


