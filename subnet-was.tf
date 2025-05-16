resource "aws_subnet" "was" {

  for_each = lookup(local.subnet_region_cidrs, "was")

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value
  availability_zone = "${var.common_attr.region}${each.key}"

  tags = merge({
    Name = "${var.common_attr.name}-${var.common_attr.env}-was-subnet-${each.key}"
  }, var.tag_attr)
}

resource "aws_route_table" "was_rt" {
  vpc_id = aws_vpc.vpc.id

  dynamic "route" {
    for_each = var.vpc_attr.is_nat ? [1] : []

    content {
      cidr_block     = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.nat[0].id
    }
  }

  tags = merge({
    Name = "${var.common_attr.name}-${var.common_attr.env}-was-rt"
  }, var.tag_attr, var.subnet_tags_attr["was"])
}

resource "aws_route_table_association" "was_rt_association" {
  for_each       = lookup(local.subnet_region_cidrs, "was")
  subnet_id      = aws_subnet.was[each.key].id
  route_table_id = aws_route_table.was_rt.id
}

resource "aws_network_acl" "was_nacl" {
  vpc_id = aws_vpc.vpc.id

  subnet_ids = [for k, v in aws_subnet.was : v.id]

  dynamic "ingress" {
    for_each = {
      for k, v in var.was_nacl_attr["ingress"] : k => v
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
      for k, v in var.was_nacl_attr["egress"] : k => v
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
    Name = "${var.common_attr.name}-${var.common_attr.env}-was-nacl"
  }, var.tag_attr)
}

output "was_subnet_ids" {
  value = {
    for k, v in aws_subnet.was : k => v.id
  }
}
