resource "aws_eip" "nat_eip" {
  count = var.vpc_attr.is_nat ? 1 : 0
  tags = {
    Name = "${var.common_attr.name}-${var.common_attr.env}-nat-eip"
  }
}

resource "aws_nat_gateway" "nat" {
  count = var.vpc_attr.is_nat ? 1 : 0

  allocation_id = aws_eip.nat_eip[0].id
  subnet_id     = lookup(aws_subnet.webservers, "a").id

  tags = {
    Name = "${var.common_attr.name}-${var.common_attr.env}-nat"
  }
}
