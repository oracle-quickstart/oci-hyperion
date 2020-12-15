/*Copyright © 2020, Oracle and/or its affiliates.

The Universal Permissive License (UPL), Version 1.0*/

variable "compartment_ocid" {
  description = "Compartment name"
}

variable "fault_domain" {
  description = "Fault Domainr"
  type        = list(string)
}

variable "compute_instance_count" {
}

variable "compute_instance_shape" {
}

variable "compute_hostname_prefix" {
  description = "Host name"
}

variable "compute_image" {
  description = "OS Image"
}

variable "compute_subnet" {
  description = "subnet"
}

variable "availability_domain" {
  type = list(string)
}

variable "compute_block_volume_size_in_gb" {
}

variable "compute_block_volume_vpus_per_gb" {
}

variable "timeout" {
  description = "Timeout setting for resource creation "
  default     = "30m"
}

variable "user_data" {
}

variable "compute_platform" {
}

variable "freeform_tags" {
  type = map(any)
  default = {
    environment = "dev"
  }
}

