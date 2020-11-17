%{ for i in environments ~}
module "developer_role_${i}" {
  depends_on = [aws_organizations_organization.organization]
  source         = "./developer-role//"
  trusted_entity = "arn:aws:iam::$${aws_organizations_organization.organization.master_account_id}:root"

  providers = {
    aws = aws.${i}
  }
}

%{ endfor ~}