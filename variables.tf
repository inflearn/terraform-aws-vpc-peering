variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "peer_vpc_id" {
  type = string
}

variable "vpc_cidr_block" {
  type = string
}

variable "peer_vpc_cidr_block" {
  type = string
}

variable "vpc_allow_dns" {
  type    = bool
  default = true
}

variable "peer_vpc_allow_dns" {
  type    = bool
  default = true
}

variable "vpc_route_table_ids" {
  type    = list(string)
  default = []
}

variable "peer_vpc_route_table_ids" {
  type    = list(string)
  default = []
}

variable "auto_accept" {
  type    = bool
  default = false
}

variable "tags" {
  type    = map(string)
  default = {}
}
