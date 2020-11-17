locals {
  environments = yamldecode(file("environments.yaml"))
}

terraform {
  source = "../../../modules//organisations/"
}

inputs = {
  environments = local.environments
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = templatefile( "./templates/provider.tpl", { environments = keys(local.environments)})
}

generate "developer_role" {
  path      = "developer_role.tf"
  if_exists = "overwrite"
  contents  = templatefile( "./templates/developer_role.tpl", { environments = keys(local.environments)})
}

generate "developer_group" {
  path      = "developer_group.tf"
  if_exists = "overwrite"
  contents  = templatefile( "./templates/developer_group.tpl", { environments = keys(local.environments)})
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket  = "solidghost-tfstate"
    key     = "${path_relative_to_include()}/terraform.tfstate"
    region  = "eu-central-1"
    encrypt = true
    // TODO
    // dynamodb_table = "my-lock-table"
  }
}
