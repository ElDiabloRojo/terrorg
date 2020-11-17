%{ for i in environments ~}

locals {
  ${i} = title("${i}")
}

module "developer_group_${i}" {
  source     = "./developer-group//"
  group_name = "Developer$${local.${i}}"

  assume_role_arns = [
    module.developer_role_${i}.role_arn
  ]

  providers = {
    aws = aws.${i}
  }
}

%{ endfor ~}