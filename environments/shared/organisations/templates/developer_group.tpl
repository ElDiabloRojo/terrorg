%{ for i in environments ~}
module "developer_group_${i}" {
  source     = "./developer-group//"
  group_name = title("developers${i}")

  assume_role_arns = [
    "module.developer_role.${i}}.role_arn"
  ]

  providers = {
    aws = aws.${i}
  }
}

%{ endfor ~}