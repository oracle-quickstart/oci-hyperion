/*Copyright © 2020, Oracle and/or its affiliates.

The Universal Permissive License (UPL), Version 1.0*/

output "subnetid" {
  value = oci_core_subnet.subnet.id
}

output "cidr_block" {
  value = oci_core_subnet.subnet.cidr_block
}

