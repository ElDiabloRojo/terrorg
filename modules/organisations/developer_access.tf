module "developer_role" {
  for_each = var.environments
  source         = "./developer-role//"
  trusted_entity = "arn:aws:iam::$${aws_organizations_account.${each.value["name"]}.users.id}:root"

  providers = {
    aws = aws.staging
  }
}

module "developer_group" {
  for_each = var.environments
  source     = "./developer-group//"
  group_name = "DevelopersStaging"

  assume_role_arns = [
    "module.developer_role.${each.value["name"]}.role_arn"
  ]

}


# single fire resources for main account

resource "aws_iam_group" "self_managing" {
  name = "SelfManaging"

}

resource "aws_iam_group_policy_attachment" "iam_read_only_access" {
  group      = aws_iam_group.self_managing.name
  policy_arn = "arn:aws:iam::aws:policy/IAMReadOnlyAccess"

}

resource "aws_iam_group_policy_attachment" "iam_self_manage_service_specific_credentials" {
  group      = aws_iam_group.self_managing.name
  policy_arn = "arn:aws:iam::aws:policy/IAMSelfManageServiceSpecificCredentials"

}

resource "aws_iam_group_policy_attachment" "iam_user_change_password" {
  group      = aws_iam_group.self_managing.name
  policy_arn = "arn:aws:iam::aws:policy/IAMUserChangePassword"

}

resource "aws_iam_policy" "self_manage_vmfa" {
  name   = "SelfManageVMFA"
  policy = file("${path.module}/data/self_manage_vmfa.json")

}

resource "aws_iam_group_policy_attachment" "self_manage_vmfa" {
  group      = aws_iam_group.self_managing.name
  policy_arn = aws_iam_policy.self_manage_vmfa.arn

}
