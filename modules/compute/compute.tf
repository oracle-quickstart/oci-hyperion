/*Copyright © 2020, Oracle and/or its affiliates.

The Universal Permissive License (UPL), Version 1.0*/

resource "oci_core_instance" "compute" {
  count               = var.compute_instance_count
  availability_domain = element(var.availability_domain, count.index)
  display_name        = "${var.compute_hostname_prefix}${substr(element(var.availability_domain, count.index), -1, 1)}${count.index + 1}"
  fault_domain        = element(var.fault_domain, count.index)
  compartment_id      = var.compartment_ocid
  shape               = var.compute_instance_shape
  freeform_tags       = var.freeform_tags

  create_vnic_details {
    subnet_id        = var.compute_subnet
    display_name     = "${var.compute_hostname_prefix}${substr(element(var.availability_domain, count.index), -1, 1)}${count.index + 1}"
    assign_public_ip = false
    hostname_label   = "${var.compute_hostname_prefix}${substr(element(var.availability_domain, count.index), -1, 1)}${count.index + 1}"
    freeform_tags    = var.freeform_tags
  }

  source_details {
    source_type = "image"
    source_id   = var.compute_image
    #    boot_volume_size_in_gbs = "${var.compute_boot_volume_size_in_gb}"
  }

  metadata = {
    #    ssh_authorized_keys = "${trimspace(file("${var.compute_ssh_public_key}"))}"
    user_data = base64encode(var.user_data)
  }

  timeouts {
    create = var.timeout
  }

  lifecycle {
    ignore_changes = [availability_domain, fault_domain]
  }
}

