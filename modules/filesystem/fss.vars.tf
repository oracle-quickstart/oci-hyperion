/*Copyright © 2020, Oracle and/or its affiliates.

The Universal Permissive License (UPL), Version 1.0*/


variable "compartment_ocid" {
  description = "Compartment name"
}

variable "availability_domain" {
  type = list(string)
}

variable "fss_instance_prefix" {}

variable "fss_subnet" {

}
variable "export_path_fs1_mt1" {
  default = "/stage/software"
}

variable "fss_limit_size_in_gb" {
}

variable fss_count {}

variable "freeform_tags" {
  type = map(any)
  default = {
    environment = "dev"
  }
}


