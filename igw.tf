################################### igw ###################################
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = merge({
    Resource = "igw"
    Name     = "${lookup(var.common_attr, "name")}-${lookup(var.common_attr, "env")}-igw"
  }, var.tag_attr)
}

output "igw_id" {
  value = aws_internet_gateway.igw.id
}
