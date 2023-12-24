variable "aws_provider_configuration" {
  type = object({
    region     = string
    access_key = string
    secret_key = string
  })
  sensitive = true
  nullable  = false
}

variable "environment" {
  type     = string
  default  = "dev"
  nullable = false
}

variable "product" {
  type     = string
  nullable = false
}