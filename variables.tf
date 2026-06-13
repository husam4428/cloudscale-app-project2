variable "resource_group_name" {
  type    = string
  default = "husam-abdelmoez-proj2-aci-rg"
}

variable "location" {
  type    = string
  default = "East US"
}

variable "container_image" {
  type    = string
  default = "husam4428/cloudscale-app:v1"
}