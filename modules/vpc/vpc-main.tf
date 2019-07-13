
resource "aws_vpc" "vpc" {
  cidr_block = "10.${var.vpc_index}.0.0/16"

  tags {
    Name    = "${var.project} vpc"
    Project = "${var.project}"
  }
}

resource "aws_internet_gateway" "ig" {
  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.vpc.id}"
  
}
