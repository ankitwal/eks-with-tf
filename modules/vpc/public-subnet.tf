resource "aws_subnet" "public" {
  count             = var.az_count
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${cidrsubnet(aws_vpc.vpc.cidr_block, 8, count.index+1)}"
  availability_zone = "${var.availability_zones[count.index]}"

  tags = {
    Name    = "${var.project} ${var.availability_zones[count.index]} public subnet"
    Project = "${var.project}"
  }
}

#Associate subnets with vpc routable
resource "aws_route_table_association" "public" {
  count          = var.az_count
  subnet_id      = "${aws_subnet.public.*.id[count.index]}"
  route_table_id = "${aws_route_table.public.id}"
}

#Direct internet bound traffic through IG.
resource "aws_route" "internet_route" {
  route_table_id         = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.ig.id}"
}