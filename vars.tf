variable "common_attr" {
  description = "공통 정보"

  default = {
    name   = ""
    env    = ""
    region = "ap-northeast-2"
  }
}

variable "vpc_attr" {

  description = "VPC 정보"

  default = {
    cidr_block = "10.0.0.0/16",
    azs        = 2
    subnet_cidrs = {
      "webserver" : ["10.0.1.0/24", "10.0.2.0/24"],
      "was" : ["10.0.3.0/24", "10.0.4.0/24"],
      "db" : ["10.0.5.0/24", "10.0.6.0/24"]
    }
    is_nat = true
  }

  validation {
    condition     = var.vpc_attr.azs < 4
    error_message = "azs must be less than 3"
  }
}

variable "subnet_tags_attr" {
  default = {
    "webserver" : {},
    "was" : {},
    "db" : {}
  }
}

variable "tag_attr" {

}

variable "webserver_nacl_attr" {
  default = {
    "ingress" : {
      "100" : {
        "protocol" : "tcp",
        "action" : "allow",
        "cidr_block" : "0.0.0.0/0",
        "from_port" : 80,
        "to_port" : 80
      },
      "101" : {
        "protocol" : "tcp",
        "action" : "allow",
        "cidr_block" : "0.0.0.0/0",
        "from_port" : 443,
        "to_port" : 443
      }
    },
    "egress" : {
      "100" : {
        "protocol" : "-1",
        "action" : "allow",
        "cidr_block" : "0.0.0.0/0",
        "from_port" : 0,
        "to_port" : 0
      }
    }
  }
}

variable "was_nacl_attr" {
  default = {
    "ingress" : {
      "100" : {
        "protocol" : "-1",
        "action" : "allow",
        "cidr_block" : "0.0.0.0/0",
        "from_port" : 0,
        "to_port" : 0
      }
    },
    "egress" : {
      "100" : {
        "protocol" : "-1",
        "action" : "allow",
        "cidr_block" : "0.0.0.0/0",
        "from_port" : 0,
        "to_port" : 0
      },
    }
  }

}

variable "db_nacl_attr" {
  default = {
    "ingress" : {
      "100" : {
        "protocol" : "-1",
        "action" : "allow",
        "cidr_block" : "0.0.0.0/0",
        "from_port" : 0,
        "to_port" : 0
      },
    },
    "egress" : {
      "100" : {
        "protocol" : "-1",
        "action" : "allow",
        "cidr_block" : "0.0.0.0/0",
        "from_port" : 0,
        "to_port" : 0
      }
    }
  }
}




