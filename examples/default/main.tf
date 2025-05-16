provider "aws" {
  profile = "leedonggyu"
  region  = "ap-northeast-2"
}

module "vpc" {
  source = "../../"

  common_attr = {
    name   = "default"
    env    = "dev"
    region = "ap-northeast-2"
  }

  vpc_attr = {
    cidr_block = "10.0.0.0/16"
    azs        = 2
    subnet_cidrs = {
      "webserver" : ["10.0.1.0/24", "10.0.2.0/24"],
      "was" : ["10.0.3.0/24", "10.0.4.0/24"],
      "db" : ["10.0.5.0/24", "10.0.6.0/24"]
    }
    is_nat = false
  }

  subnet_tags_attr = {
    "webserver" : {
      "Properties" : "webserver"
    },
    "was" : {
      "Properties" : "was"
    },
    "db" : {
      "Properties" : "db"
    }
  }

  tag_attr = {
    "Common" : "aaa"
  }

  webserver_nacl_attr = {
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
      },
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

  was_nacl_attr = {
    "ingress" : {
      "100" : {
        "protocol" : "tcp",
        "action" : "allow",
        "cidr_block" : "10.0.0.0/16",
        "from_port" : 3000,
        "to_port" : 3000
      },
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

  db_nacl_attr = {
    "ingress" : {
      "100" : {
        "protocol" : "tcp",
        "action" : "allow",
        "cidr_block" : "10.0.0.0/16",
        "from_port" : 3306,
        "to_port" : 3306
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

output "v" {
  value = module.vpc
}



