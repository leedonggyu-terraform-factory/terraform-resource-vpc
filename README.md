<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.nat_eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_network_acl.db_nacl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl) | resource |
| [aws_network_acl.was_nacl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl) | resource |
| [aws_network_acl.webserver_nacl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl) | resource |
| [aws_route_table.db_rt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.was_rt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.webserver_rt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.db_rt_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.was_rt_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.webserver_rt_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.was](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.webservers](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common_attr"></a> [common\_attr](#input\_common\_attr) | 공통 정보 | `map` | <pre>{<br/>  "env": "",<br/>  "name": "",<br/>  "region": "ap-northeast-2"<br/>}</pre> | no |
| <a name="input_db_nacl_attr"></a> [db\_nacl\_attr](#input\_db\_nacl\_attr) | n/a | `map` | <pre>{<br/>  "egress": {<br/>    "100": {<br/>      "action": "allow",<br/>      "cidr_block": "0.0.0.0/0",<br/>      "from_port": 0,<br/>      "protocol": "-1",<br/>      "to_port": 0<br/>    }<br/>  },<br/>  "ingress": {<br/>    "100": {<br/>      "action": "allow",<br/>      "cidr_block": "0.0.0.0/0",<br/>      "from_port": 0,<br/>      "protocol": "-1",<br/>      "to_port": 0<br/>    }<br/>  }<br/>}</pre> | no |
| <a name="input_subnet_tags_attr"></a> [subnet\_tags\_attr](#input\_subnet\_tags\_attr) | n/a | `map` | <pre>{<br/>  "db": {},<br/>  "was": {},<br/>  "webserver": {}<br/>}</pre> | no |
| <a name="input_tag_attr"></a> [tag\_attr](#input\_tag\_attr) | n/a | `any` | n/a | yes |
| <a name="input_vpc_attr"></a> [vpc\_attr](#input\_vpc\_attr) | VPC 정보 | `map` | <pre>{<br/>  "azs": 2,<br/>  "cidr_block": "10.0.0.0/16",<br/>  "is_nat": true,<br/>  "subnet_cidrs": {<br/>    "db": [<br/>      "10.0.5.0/24",<br/>      "10.0.6.0/24"<br/>    ],<br/>    "was": [<br/>      "10.0.3.0/24",<br/>      "10.0.4.0/24"<br/>    ],<br/>    "webserver": [<br/>      "10.0.1.0/24",<br/>      "10.0.2.0/24"<br/>    ]<br/>  }<br/>}</pre> | no |
| <a name="input_was_nacl_attr"></a> [was\_nacl\_attr](#input\_was\_nacl\_attr) | n/a | `map` | <pre>{<br/>  "egress": {<br/>    "100": {<br/>      "action": "allow",<br/>      "cidr_block": "0.0.0.0/0",<br/>      "from_port": 0,<br/>      "protocol": "-1",<br/>      "to_port": 0<br/>    }<br/>  },<br/>  "ingress": {<br/>    "100": {<br/>      "action": "allow",<br/>      "cidr_block": "0.0.0.0/0",<br/>      "from_port": 0,<br/>      "protocol": "-1",<br/>      "to_port": 0<br/>    }<br/>  }<br/>}</pre> | no |
| <a name="input_webserver_nacl_attr"></a> [webserver\_nacl\_attr](#input\_webserver\_nacl\_attr) | n/a | `map` | <pre>{<br/>  "egress": {<br/>    "100": {<br/>      "action": "allow",<br/>      "cidr_block": "0.0.0.0/0",<br/>      "from_port": 0,<br/>      "protocol": "-1",<br/>      "to_port": 0<br/>    }<br/>  },<br/>  "ingress": {<br/>    "100": {<br/>      "action": "allow",<br/>      "cidr_block": "0.0.0.0/0",<br/>      "from_port": 80,<br/>      "protocol": "tcp",<br/>      "to_port": 80<br/>    },<br/>    "101": {<br/>      "action": "allow",<br/>      "cidr_block": "0.0.0.0/0",<br/>      "from_port": 443,<br/>      "protocol": "tcp",<br/>      "to_port": 443<br/>    }<br/>  }<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_db_subnet_ids"></a> [db\_subnet\_ids](#output\_db\_subnet\_ids) | n/a |
| <a name="output_igw_id"></a> [igw\_id](#output\_igw\_id) | n/a |
| <a name="output_region"></a> [region](#output\_region) | n/a |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | n/a |
| <a name="output_was_subnet_ids"></a> [was\_subnet\_ids](#output\_was\_subnet\_ids) | n/a |
| <a name="output_webserver_subnet_ids"></a> [webserver\_subnet\_ids](#output\_webserver\_subnet\_ids) | n/a |
<!-- END_TF_DOCS -->
