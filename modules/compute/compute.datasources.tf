/*Copyright © 2020, Oracle and/or its affiliates.

The Universal Permissive License (UPL), Version 1.0*/

# Fetch Windows instance credentials
data "oci_core_instance_credentials" "win" {
  count       = var.compute_platform != "linux" ? var.compute_instance_count : 0
  instance_id = oci_core_instance.compute[count.index].id
}

