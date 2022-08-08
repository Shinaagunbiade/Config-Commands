#
# Variables Configuration
#

variable "cluster-name" {
  default = "tha-prod-cluster"
  type    = string
}
variable "key_pair_name" {
  default = "ekskey"
}
variable "eks_node_instance_type" {
  default = "t3.small"
}
