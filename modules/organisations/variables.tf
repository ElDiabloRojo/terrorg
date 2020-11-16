variable "environments" {
  type = map(object({
    name      = string
    email     = string
    role_name = string
  }))
}