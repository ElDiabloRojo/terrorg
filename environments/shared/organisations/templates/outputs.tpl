
output "links" {
  value = {
    aws_console_sign_in    = "https://$${aws_organizations_organization.organization.master_account_id}.signin.aws.amazon.com/console/"
    %{ for i in environments ~}
    switch_role_${i} = "https://signin.aws.amazon.com/switchrole?account=$${aws_organizations_account.account["${i}"].id}&roleName=$${urlencode(module.developer_role_${i}.role_name)}&displayName=$${urlencode("Developer@${i}")}"
    %{ endfor ~}
  }
}
