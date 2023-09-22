variable "my_ip" {
  description = "(Required) Your IP address used for SSH access."
  type        = string
}

variable "existing_key_name" {
  description = "(Required) The name of an existing key pair."
  type        = string
}