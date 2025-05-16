resource "aws_vpc" "vpc" {
  cidr_block = lookup(var.vpc_attr, "cidr_block")

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge({
    Name     = "${lookup(var.common_attr, "name")}-${lookup(var.common_attr, "env")}-vpc"
    Resource = "vpc"
  }, var.tag_attr)
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "region" {
  value = lookup(var.common_attr, "region")
}
