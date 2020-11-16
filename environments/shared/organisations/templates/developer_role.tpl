%{ for i in environments ~}
module "developer_role_${i}" {
  source         = "./developer-role//"
  trusted_entity = "arn:aws:iam::$${aws_organizations_account.account["${i}"].id}:root"

  providers = {
    aws = aws.${i}
  }
}

%{ endfor ~}