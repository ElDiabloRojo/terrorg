locals {
  environments = {
    development = {
      name = "development"
      email = "ceaseless.gaia.development@gmail.com"
      role_name = "Admin"
    },
    users = {
      name = "users"
      email = "ceaseless.gaia.development@gmail.com"
      role_name = "Admin"
    }
  }
}

terraform {
  source = "../../modules/organisations//"
}

inputs = {
  environments = local.environments
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = templatefile( "./templates/provider.tpl", { environments = keys(local.environments) } )
}