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
  contents  = templatefile( "./templates/provider.tpl", { environments = keys(local.environments) } )
}