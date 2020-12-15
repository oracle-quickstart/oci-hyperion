/*Copyright © 2020, Oracle and/or its affiliates.

The Universal Permissive License (UPL), Version 1.0*/

# Get list of Availability Domains
data "oci_identity_availability_domains" "ADs" {
  compartment_id = var.tenancy_ocid
}

# Get name of Availability Domains
data "template_file" "deployment_ad" {
  count    = length(var.AD)
  template = data.oci_identity_availability_domains.ADs.availability_domains[var.AD[count.index] - 1]["name"]
}

# Get list of Fault Domains
data "oci_identity_fault_domains" "fds" {
  count               = length(var.AD)
  availability_domain = element(data.template_file.deployment_ad.*.rendered, count.index)
  compartment_id      = var.compartment_ocid
}

locals {
  fault_domains       = flatten(concat(data.oci_identity_fault_domains.fds.*.fault_domains))
  faultdomains_per_ad = 3
}

# Get name of Fault Domains
data "template_file" "deployment_fd" {
  template = "$${name}"
  count    = length(var.AD) * local.faultdomains_per_ad
  vars = {
    name = local.fault_domains[count.index]["name"]
  }
}

# Get latest Oracle Linux image
data "oci_core_images" "InstanceImageOCID" {
  compartment_id           = var.tenancy_ocid
  operating_system         = var.instance_os
  operating_system_version = var.linux_os_version
  sort_by                  = "TIMECREATED"
  sort_order               = "DESC"
  state                    = "AVAILABLE"
  filter {
    name   = "display_name"
    values = ["^.*Oracle[^G]*$"]
    regex  = true
  }
}

# Get swift object storage name for Service Gateway
data "oci_core_services" "svcgtw_services" {
  filter {
    name   = "name"
    values = [".*Object.*Storage"]
    regex  = true
  }
}

data "template_file" "bootstrap" {
  template = file("${path.module}/userdata/cloudinit.ps1")
  vars = {
    fss_mount_path              = var.epm_shared_filesystem_path
    fss_export_path             = element(module.create_fss.FilesystemExports, 0)
    fss_mount_target_private_ip = element(module.create_fss.FilesystemPrivateIPs, 0)
  }
}

