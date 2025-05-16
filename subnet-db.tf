resource "aws_subnet" "db" {

  for_each = lookup(local.subnet_region_cidrs, "db")

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value
  availability_zone = "${var.common_attr.region}${each.key}"

  tags = merge({
    Name = "${var.common_attr.name}-${var.common_attr.env}-db-subnet-${each.key}"
  }, var.tag_attr)
}

resource "aws_route_table" "db_rt" {
  vpc_id = aws_vpc.vpc.id

  tags = merge({
    Name = "${var.common_attr.name}-${var.common_attr.env}-db-rt"
  }, var.tag_attr, var.subnet_tags_attr["db"])
}

resource "aws_route_table_association" "db_rt_association" {
  for_each       = lookup(local.subnet_region_cidrs, "db")
  subnet_id      = aws_subnet.db[each.key].id
  route_table_id = aws_route_table.db_rt.id
}

resource "aws_network_acl" "db_nacl" {
  vpc_id = aws_vpc.vpc.id

  subnet_ids = [for k, v in aws_subnet.db : v.id]

  dynamic "ingress" {
    for_each = {
      for k, v in var.db_nacl_attr["ingress"] : k => v
    }

    content {
      rule_no    = ingress.key
      protocol   = ingress.value.protocol
      action     = ingress.value.action
      cidr_block = ingress.value.cidr_block
      from_port  = ingress.value.from_port
      to_port    = ingress.value.to_port
    }
  }

  dynamic "egress" {
    for_each = {
      for k, v in var.db_nacl_attr["egress"] : k => v
    }

    content {
      rule_no    = egress.key
      protocol   = egress.value.protocol
      action     = egress.value.action
      cidr_block = egress.value.cidr_block
      from_port  = egress.value.from_port
      to_port    = egress.value.to_port
    }
  }

  tags = merge({
    Name = "${var.common_attr.name}-${var.common_attr.env}-db-nacl"
  }, var.tag_attr)
}

output "db_subnet_ids" {
  value = {
    for k, v in aws_subnet.db : k => v.id
  }
}
