
resource "aws_organizations_organization" "organization" {
}

resource "aws_organizations_account" "account" {
  for_each = var.environments
  name      = each.value["name"]
  email     = each.value["email"]
  role_name = each.value["role_name"]
}
