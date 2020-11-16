
provider "aws" {
  region = "eu-central-1"
}

%{ for i in environments ~}
provider "aws" {
  assume_role {
    role_arn = "arn:aws:iam::$${aws_organizations_account.account["${i}"].id}:role/Admin"
  }
  alias = "${i}"
  region = "eu-central-1"
}

%{ endfor ~}