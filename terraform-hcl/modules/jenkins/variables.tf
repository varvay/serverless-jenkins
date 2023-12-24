variable "environment" {
  type     = string
  default  = "dev"
  nullable = false
}

variable "product" {
  type     = string
  nullable = false
}

variable "subnet" {
  type = object({
    id = string
  })
  nullable = false
}

variable "security_group" {
  type = object({
    id = string
  })
  nullable = false
}
