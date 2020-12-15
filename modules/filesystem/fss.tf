/*Copyright © 2018, Oracle and/or its affiliates.

The Universal Permissive License (UPL), Version 1.0*/


resource "oci_file_storage_file_system" "fss" {
  compartment_id      = var.compartment_ocid
  count               = var.fss_count
  availability_domain = element(var.availability_domain, count.index)
  display_name        = "${var.fss_instance_prefix}${substr(element(var.availability_domain, count.index), -1, 1)}"
  freeform_tags       = var.freeform_tags
}

resource "oci_file_storage_mount_target" "fss_mt" {
  depends_on = [
    oci_file_storage_file_system.fss
  ]
  compartment_id      = var.compartment_ocid
  count               = var.fss_count
  availability_domain = element(var.availability_domain, count.index)
  hostname_label      = "${var.fss_instance_prefix}${substr(element(var.availability_domain, count.index), -1, 1)}"
  subnet_id           = var.fss_subnet
  display_name        = "${var.fss_instance_prefix}${substr(element(var.availability_domain, count.index), -1, 1)}_mt"
  freeform_tags       = var.freeform_tags
}

resource "oci_file_storage_export_set" "fss_export_set" {
  depends_on = [
    oci_file_storage_file_system.fss,
    oci_file_storage_mount_target.fss_mt
  ]
  count             = var.fss_count
  mount_target_id   = element(oci_file_storage_mount_target.fss_mt.*.id, count.index)
  max_fs_stat_bytes = var.fss_limit_size_in_gb * 1024 * 1024 * 1024
}
resource "oci_file_storage_export" "fss_export" {
  depends_on = [
    oci_file_storage_file_system.fss,
    oci_file_storage_mount_target.fss_mt
  ]
  count          = var.fss_count
  export_set_id  = element(oci_file_storage_mount_target.fss_mt.*.export_set_id, count.index)
  file_system_id = element(oci_file_storage_file_system.fss.*.id, count.index)
  path           = "/${var.fss_instance_prefix}${substr(var.availability_domain[count.index], -1, 1)}"

  export_options {
    source                         = "0.0.0.0/0"
    access                         = "READ_WRITE"
    identity_squash                = "NONE"
    require_privileged_source_port = false
  }
}



