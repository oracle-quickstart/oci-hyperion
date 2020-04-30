/*Copyright © 2020, Oracle and/or its affiliates.

The Universal Permissive License (UPL), Version 1.0*/

locals {
  // VCN is /16
  vcn_subnet_cidr_offset  = 8
  bastion_subnet_prefix   = "${cidrsubnet("${var.vcn_cidr}", local.vcn_subnet_cidr_offset, 0)}"
  lb_subnet_prefix        = "${cidrsubnet("${var.vcn_cidr}", local.vcn_subnet_cidr_offset, 1)}"
  web_subnet_prefix       = "${cidrsubnet("${var.vcn_cidr}", local.vcn_subnet_cidr_offset, 2)}"
  app_subnet_prefix       = "${cidrsubnet("${var.vcn_cidr}", local.vcn_subnet_cidr_offset, 3)}"
  db_subnet_prefix        = "${cidrsubnet("${var.vcn_cidr}", local.vcn_subnet_cidr_offset, 4)}"
}

# Create Virtual Cloud Network (VCN)
module "create_vcn" {
  source = "./modules/network/vcn"

  compartment_ocid    = "${var.compartment_ocid}"
  vcn_cidr            = "${var.vcn_cidr}"
  vcn_dns_label       = "${var.vcn_dns_label}"
}

# Create bastion host subnet
module "bastion_subnet" {
  source  = "./modules/network/subnets"

  compartment_ocid    = "${var.compartment_ocid}"
  vcn_id              = "${module.create_vcn.vcnid}"
  vcn_subnet_cidr     = "${local.bastion_subnet_prefix}"
  dns_label           = "bassubnet"
  dhcp_options_id     = "${module.create_vcn.default_dhcp_id}"
  route_table_id      = "${oci_core_route_table.PublicRT.id}"
  security_list_ids   = ["${oci_core_security_list.BastionSecList.id}"]
  private_subnet      = "false"
}

# Create Load Balancer subnet
module "lb_subnet" {
  source  = "./modules/network/subnets"

  compartment_ocid    = "${var.compartment_ocid}"
  vcn_id              = "${module.create_vcn.vcnid}"
  vcn_subnet_cidr     = "${local.lb_subnet_prefix}"
  dns_label           = "lbsubnet"
  dhcp_options_id     = "${module.create_vcn.default_dhcp_id}"
  route_table_id      = "${oci_core_route_table.PublicRT.id}"
  security_list_ids   = ["${oci_core_security_list.LBSecList.id}"]
  private_subnet      = "${var.load_balancer_private}"
}


# Create web subnet
module "web_subnet" {
  source  = "./modules/network/subnets"

  compartment_ocid    = "${var.compartment_ocid}"
  vcn_id              = "${module.create_vcn.vcnid}"
  vcn_subnet_cidr     = "${local.web_subnet_prefix}"
  dns_label           = "websubnet"
  dhcp_options_id     = "${module.create_vcn.default_dhcp_id}"
  route_table_id      = "${oci_core_route_table.PrivateRT.id}"
  security_list_ids   = ["${oci_core_security_list.WebSecList.id}"]
  private_subnet      = "true"
}

# Create app subnet
module "app_subnet" {
  source  = "./modules/network/subnets"

  compartment_ocid    = "${var.compartment_ocid}"
  vcn_id              = "${module.create_vcn.vcnid}"
  vcn_subnet_cidr     = "${local.app_subnet_prefix}"
  dns_label           = "appsubnet"
  dhcp_options_id     = "${module.create_vcn.default_dhcp_id}"
  route_table_id      = "${oci_core_route_table.PrivateRT.id}"
  security_list_ids   = ["${oci_core_security_list.AppSecList.id}"]
  private_subnet      = "true"
}


# Create database subnet
module "db_subnet" {
  source  = "./modules/network/subnets"

  compartment_ocid    = "${var.compartment_ocid}"
  vcn_id              = "${module.create_vcn.vcnid}"
  vcn_subnet_cidr     = "${local.db_subnet_prefix}"
  dns_label           = "dbsubnet"
  dhcp_options_id     = "${module.create_vcn.default_dhcp_id}"
  route_table_id      = "${oci_core_route_table.PrivateRT.id}"
  security_list_ids   = ["${oci_core_security_list.DBSecList.id}"]
  private_subnet      = "true"
}

# Create bastion host
module "create_bastion" {
  source  = "./modules/bastion"

  compartment_ocid        = "${var.compartment_ocid}"
  AD                      = "${var.AD}"
  availability_domain     = ["${data.template_file.deployment_ad.*.rendered}"]
  fault_domain            = ["${sort(data.template_file.deployment_fd.*.rendered)}"]
  bastion_hostname_prefix = "${var.epm_env_prefix}bas${substr(var.region, 3, 3)}"
  bastion_image           = "${data.oci_core_images.InstanceImageOCID.images.0.id}"
  bastion_instance_shape  = "${var.bastion_instance_shape}"
  bastion_subnet          = "${module.bastion_subnet.subnetid}"
#  bastion_ssh_public_key  = "${var.bastion_ssh_public_key}"
  bastion_ssh_public_key  = "${var.ssh_public_key}"
  }

# Create foundation server
module "create_foundation" {
  source = "./modules/compute"
  
  compartment_ocid                = "${var.compartment_ocid}"
  AD                              = "${var.AD}"
  availability_domain             = ["${data.template_file.deployment_ad.*.rendered}"]
  fault_domain                    = ["${sort(data.template_file.deployment_fd.*.rendered)}"]
  compute_instance_count          = "${var.epm_foundation_instance_count}"
  compute_platform                = "windows"
  compute_hostname_prefix         = "${var.epm_env_prefix}fnd${substr(var.region, 3, 3)}"
  compute_image                   = "${var.platform-images[var.region]}"
  compute_instance_shape          = "${var.epm_foundation_instance_shape}"
  compute_subnet                  = "${module.app_subnet.subnetid}"
  compute_block_volume_size_in_gb = "${var.epm_foundation_instance_bv_size_in_gb}"
  compute_block_volume_vpus_per_gb= "${var.epm_foundation_instance_bv_vpus_per_gb}"
  user_data                       = "${data.template_file.bootstrap.rendered}"
}

# Create planning server
module "create_planning" {
  source = "./modules/compute"
  
  compartment_ocid                = "${var.compartment_ocid}"
  AD                              = "${var.AD}"
  availability_domain             = ["${data.template_file.deployment_ad.*.rendered}"]
  fault_domain                    = ["${sort(data.template_file.deployment_fd.*.rendered)}"]
  compute_instance_count          = "${var.epm_planning ? var.epm_planning_instance_count : 0}"
  compute_platform                = "windows"
  compute_hostname_prefix         = "${var.epm_env_prefix}pln${substr(var.region, 3, 3)}"
  compute_image                   = "${var.platform-images[var.region]}"
  compute_instance_shape          = "${var.epm_planning_instance_shape}"
  compute_subnet                  = "${module.app_subnet.subnetid}"
  compute_block_volume_size_in_gb = "${var.epm_planning_instance_bv_size_in_gb}"
  compute_block_volume_vpus_per_gb= "${var.epm_planning_instance_bv_vpus_per_gb}"
  user_data                       = "${data.template_file.bootstrap.rendered}"
}

# Create Essbase database server
module "create_essbase" {
  source = "./modules/compute"
  
  compartment_ocid                = "${var.compartment_ocid}"
  AD                              = "${var.AD}"
  availability_domain             = ["${data.template_file.deployment_ad.*.rendered}"]
  fault_domain                    = ["${sort(data.template_file.deployment_fd.*.rendered)}"]
  compute_instance_count          = "${var.epm_planning == "true" &&  var.epm_essbase_required == "true" ? var.epm_essbase_instance_count : 0}"
  compute_platform                = "windows"
  compute_hostname_prefix         = "${var.epm_env_prefix}ess${substr(var.region, 3, 3)}"
  compute_image                   = "${var.platform-images[var.region]}"
  compute_instance_shape          = "${var.epm_essbase_instance_shape}"
  compute_subnet                  = "${module.app_subnet.subnetid}"
  compute_block_volume_size_in_gb = "${var.epm_essbase_instance_bv_size_in_gb}"
  compute_block_volume_vpus_per_gb= "${var.epm_essbase_instance_bv_vpus_per_gb}"
  user_data                       = "${data.template_file.bootstrap.rendered}"
}

# Create Financial Management server
module "create_hfm" {
  source = "./modules/compute"
  

  compartment_ocid                = "${var.compartment_ocid}"
  AD                              = "${var.AD}"
  availability_domain             = ["${data.template_file.deployment_ad.*.rendered}"]
  fault_domain                    = ["${sort(data.template_file.deployment_fd.*.rendered)}"]
  compute_instance_count          = "${var.epm_financial_management=="true" ? var.epm_hfm_instance_count : 0}"
  compute_platform                = "windows"
  compute_hostname_prefix         = "${var.epm_env_prefix}hfm${substr(var.region, 3, 3)}"
  compute_image                   = "${var.platform-images[var.region]}"
  compute_instance_shape          = "${var.epm_hfm_instance_shape}"
  compute_subnet                  = "${module.app_subnet.subnetid}"
  compute_block_volume_size_in_gb = "${var.epm_hfm_instance_bv_size_in_gb}"
  compute_block_volume_vpus_per_gb= "${var.epm_hfm_instance_bv_vpus_per_gb}"
  user_data                       = "${data.template_file.bootstrap.rendered}"
}

# Create Hyperion Tax Provisioning server
module "create_htp" {
  source = "./modules/compute"
  
  compartment_ocid                = "${var.compartment_ocid}"
  AD                              = "${var.AD}"
  availability_domain             = ["${data.template_file.deployment_ad.*.rendered}"]
  fault_domain                    = ["${sort(data.template_file.deployment_fd.*.rendered)}"]
  compute_instance_count          = "${var.epm_financial_management == "true" &&  var.epm_htp_required == "true" ? var.epm_htp_instance_count : 0}"
  compute_platform                = "windows"
  compute_hostname_prefix         = "${var.epm_env_prefix}htp${substr(var.region, 3, 3)}"
  compute_image                   = "${var.platform-images[var.region]}"
  compute_instance_shape          = "${var.epm_htp_instance_shape}"
  compute_subnet                  = "${module.app_subnet.subnetid}"
  compute_block_volume_size_in_gb = "${var.epm_htp_instance_bv_size_in_gb}"
  compute_block_volume_vpus_per_gb= "${var.epm_htp_instance_bv_vpus_per_gb}"  
  user_data                       = "${data.template_file.bootstrap.rendered}"
}

# Create Web server
module "create_web" {
  source = "./modules/compute"
  
  compartment_ocid                = "${var.compartment_ocid}"
  AD                              = "${var.AD}"
  availability_domain             = ["${data.template_file.deployment_ad.*.rendered}"]
  fault_domain                    = ["${sort(data.template_file.deployment_fd.*.rendered)}"]
  compute_instance_count          = "${var.epm_web_instance_count}"
  compute_platform                = "windows"
  compute_hostname_prefix         = "${var.epm_env_prefix}web${substr(var.region, 3, 3)}"
  compute_image                   = "${var.platform-images[var.region]}"
  compute_instance_shape          = "${var.epm_web_instance_shape}"
  compute_subnet                  = "${module.web_subnet.subnetid}"
  compute_block_volume_size_in_gb = "${var.epm_web_instance_bv_size_in_gb}"
  compute_block_volume_vpus_per_gb= "${var.epm_web_instance_bv_vpus_per_gb}"
  user_data                       = "${data.template_file.bootstrap.rendered}"
}


# Create FDMEE server
module "create_fdmee" {
  source = "./modules/compute"
  
  compartment_ocid                = "${var.compartment_ocid}"
  AD                              = "${var.AD}"
  availability_domain             = ["${data.template_file.deployment_ad.*.rendered}"]
  fault_domain                    = ["${sort(data.template_file.deployment_fd.*.rendered)}"]
  compute_instance_count          = "${var.add_additional_products == "true" &&  var.epm_fdmee_required == "true" ? var.epm_fdmee_instance_count : 0}"
  compute_platform                = "windows"
  compute_hostname_prefix         = "${var.epm_env_prefix}fdm${substr(var.region, 3, 3)}"
  compute_image                   = "${var.platform-images[var.region]}"
  compute_instance_shape          = "${var.epm_fdmee_instance_shape}"
  compute_subnet                  = "${module.app_subnet.subnetid}"
  compute_block_volume_size_in_gb = "${var.epm_fdmee_instance_bv_size_in_gb}"
  compute_block_volume_vpus_per_gb= "${var.epm_fdmee_instance_bv_vpus_per_gb}"
  user_data                       = "${data.template_file.bootstrap.rendered}"
}

# Create Profitability server
module "create_profitability" {
  source = "./modules/compute"
  
  compartment_ocid                = "${var.compartment_ocid}"
  AD                              = "${var.AD}"
  availability_domain             = ["${data.template_file.deployment_ad.*.rendered}"]
  fault_domain                    = ["${sort(data.template_file.deployment_fd.*.rendered)}"]
  compute_instance_count          = "${var.add_additional_products == "true" &&  var.epm_profitability_required == "true"? var.epm_profitability_instance_count : 0}"
  compute_platform                = "windows"
  compute_hostname_prefix         = "${var.epm_env_prefix}prof${substr(var.region, 3, 3)}"
  compute_image                   = "${var.platform-images[var.region]}"
  compute_instance_shape          = "${var.epm_profitability_instance_shape}"
  compute_subnet                  = "${module.app_subnet.subnetid}"
  compute_block_volume_size_in_gb = "${var.epm_profitability_instance_bv_size_in_gb}"
  compute_block_volume_vpus_per_gb= "${var.epm_profitability_instance_bv_vpus_per_gb}"
  user_data                       = "${data.template_file.bootstrap.rendered}"
}

# Create Strategic Finance server
module "create_strategic_finance" {
  source = "./modules/compute"
  
  compartment_ocid                = "${var.compartment_ocid}"
  AD                              = "${var.AD}"
  availability_domain             = ["${data.template_file.deployment_ad.*.rendered}"]
  fault_domain                    = ["${sort(data.template_file.deployment_fd.*.rendered)}"]
  compute_instance_count          = "${var.epm_strategic_finance_instance_count}"
  compute_instance_count          = "${var.add_additional_products == "true" && var.epm_strategic_finance_required == "true" ? var.epm_strategic_finance_instance_count : 0}"
  compute_platform                = "windows"
  compute_hostname_prefix         = "${var.epm_env_prefix}sf${substr(var.region, 3, 3)}"
  compute_image                   = "${var.platform-images[var.region]}"
  compute_instance_shape          = "${var.epm_strategic_finance_instance_shape}"
  compute_subnet                  = "${module.app_subnet.subnetid}"
  compute_block_volume_size_in_gb = "${var.epm_strategic_finance_instance_bv_size_in_gb}"
  compute_block_volume_vpus_per_gb= "${var.epm_strategic_finance_instance_bv_vpus_per_gb}"
  user_data                       = "${data.template_file.bootstrap.rendered}"
}

# Create File system service
module "create_fss" {
  source = "./modules/filesystem"

  compartment_ocid            = "${var.compartment_ocid}"
  AD                          = "${var.AD}"
  availability_domain         = ["${data.template_file.deployment_ad.*.rendered}"]
  fss_instance_prefix         = "${var.epm_env_prefix}fss${substr(var.region, 3, 3)}"
  fss_subnet                  = "${module.app_subnet.subnetid}"
  fss_limit_size_in_gb        = "${var.epm_shared_filesystem_size_limit_in_gb}"
  fss_count                   = "1"  
}

# create EPM Database system
  module "create_db" {
  source  = "./modules/dbsystem"

  compartment_ocid          = "${var.compartment_ocid}"
  AD                        = "${var.AD}"
  availability_domain       = ["${data.template_file.deployment_ad.*.rendered}"]
  fault_domain              = ["${distinct(sort(data.template_file.deployment_fd.*.rendered))}"]
  db_edition                = "${var.db_edition}"
  db_instance_count         = "${var.epm_database_required == "true" ? 1 : 0}"
  db_instance_shape         = "${var.db_instance_shape}"
  db_node_count             = "${var.db_node_count}"
  db_hostname_prefix        = "${var.epm_env_prefix}db${substr(var.region, 3, 3)}"
  db_size_in_gb             = "${var.db_size_in_gb}"
  db_autobackup_enabled     = "${var.epm_database_backup_config_required}"
  db_backup_recovery_window = "${var.epm_database_backup_recovery_window}"
  db_license_model          = "${var.db_license_model}"
  db_subnet                 = "${module.db_subnet.subnetid}"
  db_ssh_public_key         = "${var.ssh_public_key}"
  db_admin_password         = "${var.db_admin_password}"
  db_name                   = "${var.db_name}"
  db_characterset           = "${var.db_characterset}"
  db_nls_characterset       = "${var.db_nls_characterset}"
  db_version                = "${var.db_version}"
  db_pdb_name               = "${var.db_pdb_name}"
  timezone                  = "${var.timezone}"
}


# Create Foundation database system
  module "create_foundation_db" {
  source  = "./modules/dbsystem"

  compartment_ocid          = "${var.compartment_ocid}"
  AD                        = "${var.AD}"
  availability_domain       = ["${data.template_file.deployment_ad.*.rendered}"]
  fault_domain              = ["${distinct(sort(data.template_file.deployment_fd.*.rendered))}"]
  db_edition                = "${var.db_edition}"
  db_instance_count         = "${var.foundation_db_separate == "true" ? 1 : 0}"
  db_instance_shape         = "${var.foundation_db_instance_shape}"
  db_node_count             = "${var.foundation_db_node_count}"
  db_hostname_prefix        = "${var.epm_env_prefix}fnd${substr(var.region, 3, 3)}"
  db_size_in_gb             = "${var.foundation_db_size_in_gb}"
  db_autobackup_enabled     = "${var.epm_database_backup_config_required}"
  db_backup_recovery_window = "${var.epm_database_backup_recovery_window}"
  db_license_model          = "${var.foundation_db_license_model}"
  db_subnet                 = "${module.db_subnet.subnetid}"
  db_ssh_public_key         = "${var.ssh_public_key}"
  db_admin_password         = "${var.foundation_db_admin_password}"
  db_name                   = "${var.foundation_db_name}"
  db_characterset           = "${var.foundation_db_characterset}"
  db_nls_characterset       = "${var.foundation_db_nls_characterset}"
  db_version                = "${var.foundation_db_version}"
  db_pdb_name               = "${var.foundation_pdb_name}"
  timezone                  = "${var.timezone}"
}

# Create Load Balancer
module "create_lb" {
  source = "./modules/loadbalancer"

  compartment_ocid            = "${var.compartment_ocid}"
  AD                          = "${var.AD}"
  availability_domain         = ["${data.template_file.deployment_ad.*.rendered}"]
  load_balancer_shape         = "${var.load_balancer_shape}"
  load_balancer_subnet        = ["${module.lb_subnet.subnetid}"]
  load_balancer_name          = "${var.epm_env_prefix}lb${substr(var.region, 3, 3)}"
  load_balancer_hostname      = "${var.load_balancer_hostname}"
  load_balancer_listen_port   = "${var.load_balancer_listen_port}"
  load_balancer_private       = "${var.load_balancer_private}"
  web_instance_listen_port    = "${var.epm_web_instance_listen_port}"
  web_instance_count          = "${var.epm_web_instance_count}"
  be_ip_addresses             = ["${module.create_web.ComputePrivateIPs}"]
}
