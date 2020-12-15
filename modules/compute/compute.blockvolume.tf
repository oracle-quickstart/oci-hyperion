/*Copyright © 2020, Oracle and/or its affiliates.

The Universal Permissive License (UPL), Version 1.0*/

resource "oci_core_volume" "blockvolume" {
  count               = var.compute_instance_count
  availability_domain = element(var.availability_domain, count.index)
  compartment_id      = var.compartment_ocid
  display_name        = "${var.compute_hostname_prefix}vol${count.index + 1}"
  size_in_gbs         = var.compute_block_volume_size_in_gb
  vpus_per_gb         = var.compute_block_volume_vpus_per_gb
}

/*
resource "null_resource" "wait_for_cloudinit" {
  depends_on = ["oci_core_instance.compute"]

  provisioner "local-exec" {
    command = "sleep 60"
  }
}
*/
resource "oci_core_volume_attachment" "blockvolume_attach_win" {
  #  depends_on = ["null_resource.wait_for_cloudinit"]
  attachment_type = "paravirtualized"
  count           = var.compute_platform == "windows" ? var.compute_instance_count : 0
  instance_id     = element(oci_core_instance.compute.*.id, count.index)
  volume_id       = element(oci_core_volume.blockvolume.*.id, count.index)
}

