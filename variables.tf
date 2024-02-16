variable "env" {
  type    = string
  default = "dev1"
}

variable "cluster_name" {
  type    = string
  default = "sid-k8s-cluster"
}

variable "cluster_version" {
  type    = string
  default = "1.25"
}

variable "pub_subnet_ids" {
  type = list(string)
}

variable "pri_subnet_ids" {
  type = list(string)
}

variable "default_tags" {
  type = map(string)
  default = {
    "Tier"       = "frontend",
    "Department" = "Finance"
  }
}


variable "eks_oidc_root_ca_thumbprint" {
  type    = string
  default = "9e99a48a9960b14926bb7f3b02e22da2b0ab7280"
}

