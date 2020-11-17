
resource "aws_organizations_organization" "organization" {
}

resource "aws_organizations_account" "account" {
  depends_on = [aws_organizations_organization.organization]
  for_each = var.environments
  parent_id = aws_organizations_organization.organization.roots[0].id
  name      = each.value["name"]
  email     = each.value["email"]
  role_name = each.value["role_name"]
}
