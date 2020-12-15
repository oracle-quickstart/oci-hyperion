/*Copyright © 2020, Oracle and/or its affiliates.

The Universal Permissive License (UPL), Version 1.0*/

variable "load_balancer_subnet" {

}

variable "availability_domain" {
  type        = list(string)
  description = "Availability domain"
}

variable "load_balancer_name" {
}

variable "compartment_ocid" {
}

variable "load_balancer_shape" {
}

variable "freeform_tags" {
  type = map(any)
  default = {
    environment = "dev"
  }
}

variable "load_balancer_private" {
  default = "True"
}

variable "be_ip_addresses" {
  type = list(string)
}

variable "load_balancer_hostname" {
}

variable "web_instance_listen_port" {
}

variable "load_balancer_listen_port" {
}

variable "web_instance_count" {
}

