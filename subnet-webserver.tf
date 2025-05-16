resource "aws_subnet" "webservers" {

  for_each = lookup(local.subnet_region_cidrs, "webserver")

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value
  availability_zone = "${var.common_attr.region}${each.key}"

  tags = merge({
    Name = "${var.common_attr.name}-${var.common_attr.env}-webserver-subnet-${each.key}"
  }, var.tag_attr)
}

resource "aws_route_table" "webserver_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge({
    Name = "${var.common_attr.name}-${var.common_attr.env}-webserver-rt"
  }, var.tag_attr, var.subnet_tags_attr["webserver"])
}

resource "aws_route_table_association" "webserver_rt_association" {
  for_each       = lookup(local.subnet_region_cidrs, "webserver")
  subnet_id      = aws_subnet.webservers[each.key].id
  route_table_id = aws_route_table.webserver_rt.id
}

resource "aws_network_acl" "webserver_nacl" {
  vpc_id = aws_vpc.vpc.id

  subnet_ids = [for k, v in aws_subnet.webservers : v.id]

  dynamic "ingress" {
    for_each = {
      for k, v in var.webserver_nacl_attr["ingress"] : k => v
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
      for k, v in var.webserver_nacl_attr["egress"] : k => v
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
    Name = "${var.common_attr.name}-${var.common_attr.env}-webserver-nacl"
  }, var.tag_attr)
}

output "webserver_subnet_ids" {
  value = {
    for k, v in aws_subnet.webservers : k => v.id
  }
}
