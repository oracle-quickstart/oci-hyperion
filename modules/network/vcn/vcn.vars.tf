/*Copyright © 2020, Oracle and/or its affiliates.

The Universal Permissive License (UPL), Version 1.0*/

variable "compartment_ocid" {
  description = "Compartment OCID"
}

# VCN Variables
variable "vcn_cidr" {
  description = "VCN CIDR"
}

variable "vcn_dns_label" {
  description = "VCN DNS Label"
}

variable "freeform_tags" {
  type = map(any)
  default = {
    environment = "dev"
  }
}

variable "enable_ssl_ports" {
  description = "Whether private Load balancer"
  default     = false
}

variable "load_balancer_listen_port" {
  description = "Load balancer listen port"
}

variable "epm_web_instance_listen_port" {
  description = "Application instance listen port"
  default     = "19000"
}