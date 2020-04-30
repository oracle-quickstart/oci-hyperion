/*Copyright © 2020, Oracle and/or its affiliates.

The Universal Permissive License (UPL), Version 1.0*/


variable "tenancy_ocid" {}
variable "region" {}
#variable "user_ocid" {}
#variable "fingerprint" {}
#variable "private_key_path" {}
variable "compartment_ocid" {}

variable "AD" {
    type= "list"
    default = ["1"]
}

variable "ssh_public_key" {
    description = "SSH public key for instances"
}
# VCN variables
variable "vcn_cidr" {
    description = "CIDR for Virtual Cloud Network (VCN)"
#    default = "172.16.0.0/16"
}
variable "vcn_dns_label" {
    description = "DNS label for Virtual Cloud Network (VCN)"
    default = "epmvcn"
}

#Environment prefix to define name of resources
variable "epm_env_prefix" {
#    default = "epm"
}

#EPM Financial Management Variables
variable epm_financial_management {
    description = "Whether private Load balancer"
    default = false
}

variable "epm_hfm_instance_count" {
    description = "Application Server count"
    default     = "1"
}

variable "epm_hfm_instance_shape" {
    description = "Application Instance shape"
    default = "VM.Standard2.1"
}

variable "epm_hfm_instance_bv_size_in_gb" {
    description = "Boot volume size of application servers"
    default = "100"
}

variable "epm_hfm_instance_bv_vpus_per_gb" {
    description = "Boot volume size of application servers"
    default = "0"
}

#EPM HTP Variables

variable epm_htp_required {
    description = "Whether HTP is required"
    default = false
}

variable "epm_htp_instance_count" {
    description = "Application Server count"
    default = "1"
}

variable "epm_htp_instance_shape" {
    description = "Application Instance shape"
    default = "VM.Standard2.1"
}

variable "epm_htp_instance_bv_size_in_gb" {
    description = "Boot volume size of application servers"
    default = "100"
}

variable "epm_htp_instance_bv_vpus_per_gb" {
    description = "Boot volume size of application servers"
    default = "0"
}

# EPM Planning Variables 

variable epm_planning {
    description = "Whether private Load balancer"
    default = false
}
variable "epm_planning_instance_count" {
    description = "Application Server count"
    default = "1"
}

variable "epm_planning_instance_shape" {
    description = "Application Instance shape"
    default = "VM.Standard2.1"
}

variable "epm_planning_instance_bv_size_in_gb" {
    description = "Boot volume size of application servers"
    default = "100"
}

variable "epm_planning_instance_bv_vpus_per_gb" {
    description = "Boot volume size of application servers"
    default = "0"
}

variable epm_essbase_required {
    description = "Whether private Load balancer"
    default = false
}

variable "epm_essbase_instance_count" {
    description = "Application Server count"
    default     = "1"
}

variable "epm_essbase_instance_shape" {
    description = "Application Instance shape"
    default = "VM.Standard2.1"
}

variable "epm_essbase_instance_bv_size_in_gb" {
    description = "Boot volume size of application servers"
    default = "100"
}

variable "epm_essbase_instance_bv_vpus_per_gb" {
    description = "Boot volume size of application servers"
    default = "0"
}

# EPM Foundation Variables
variable "epm_foundation_instance_count" {
    description = "Application Server count"    
    default     = "1"
}

variable "epm_foundation_instance_shape" {
    description = "Application Instance shape"
    default = "VM.Standard2.1"
}

variable "epm_foundation_instance_bv_size_in_gb" {
    description = "Boot volume size of application servers"
    default = "100"
}

variable "epm_foundation_instance_bv_vpus_per_gb" {
    description = "Boot volume size of application servers"
    default = "0"
}

# Foundation database
variable foundation_db_separate {
    description = "Whether private Load balancer"
    default = false
}

variable "foundation_db_edition" {
    description = "DB Edition"
    default = "ENTERPRISE_EDITION_EXTREME_PERFORMANCE"
}

variable "foundation_db_instance_shape" {
    description = "DB Instance shape"
    default = "VM.Standard2.2"
}

variable "foundation_db_node_count" {
    description = "Number of DB Nodes"
    default="2"
}
variable "foundation_db_size_in_gb" {
    description = "Size of database in GB"
    default="256"
}
variable "foundation_db_license_model" {
    description = "Database License model"
    default= "LICENSE_INCLUDED"
}

variable "foundation_db_admin_password" {
    description = "Database Admin password"
    default=""
}

variable "foundation_db_name" {
    description = "Database Name"
    default = "FNDCDB"
}
variable "foundation_db_characterset" {
    description = "Database Characterset"
    default="AL32UTF8"
}
variable "foundation_db_nls_characterset" {
    description = "Database National Characterset"
    default="AL16UTF16"
}

variable "foundation_db_version" {
    description = "Database version"
    default="12.1.0.2" 

}

variable "foundation_pdb_name" {
    description = "Pluggable database Name"
    default = "FNDDB"   
}

# Addtional Products
variable add_additional_products {
    description = "Whether private Load balancer"
    default = false
}

# Profitability Variables
variable epm_profitability_required {
    description = "Whether private Load balancer"
    default = false
}
variable "epm_profitability_instance_count" {
    description = "Application Server count"
    default     = "1"
}

variable "epm_profitability_instance_shape" {
    description = "Application Instance shape"
    default = "VM.Standard2.1"
}

variable "epm_profitability_instance_bv_size_in_gb" {
    description = "Boot volume size of application servers"
    default = "100"
}

variable "epm_profitability_instance_bv_vpus_per_gb" {
    description = "Boot volume size of application servers"
    default = "0"
}

# Strategic Finance
variable epm_strategic_finance_required {
    description = "Whether private Load balancer"
    default = false
}

variable "epm_strategic_finance_instance_count" {
    description = "Application Server count"
    default     = "1"
}

variable "epm_strategic_finance_instance_shape" {
    description = "Application Instance shape"
    default = "VM.Standard2.1"
}

variable "epm_strategic_finance_instance_bv_size_in_gb" {
    description = "Boot volume size of application servers"
    default = "100"
}

variable "epm_strategic_finance_instance_bv_vpus_per_gb" {
    description = "Boot volume size of application servers"
    default = "0"
}
# FDMEE
variable epm_fdmee_required {
    description = "Whether private Load balancer"
    default = false
}

variable "epm_fdmee_instance_count" {
    description = "Application Server count"
    default     = "1"
}

variable "epm_fdmee_instance_shape" {
    description = "Application Instance shape"
    default = "VM.Standard2.1"
}


variable "epm_fdmee_instance_bv_size_in_gb" {
    description = "Boot volume size of application servers"
    default = "100"
}

variable "epm_fdmee_instance_bv_vpus_per_gb" {
    description = "Boot volume size of application servers"
    default = "0"
}

# Web Instnace
variable "epm_web_instance_count" {
    description = "Application Server count"
    default     = "1"
}

variable "epm_web_instance_shape" {
    description = "Application Instance shape"
    default = "VM.Standard2.1"
}

variable "epm_web_instance_listen_port" {
    description = "Application instance listen port"
    default = "19000"
#    type        = "list"
}

variable "epm_web_instance_bv_size_in_gb" {
    description = "Boot volume size of application servers"
    default = "100"
}

variable "epm_web_instance_bv_vpus_per_gb" {
    description = "Boot volume size of application servers"
    default = "0"
}


variable "timezone" {
    description = "Set timezone for servers"
    default = "America/New_York"
}

# Database variables

variable epm_database_required {
    description = "Whether private Load balancer"
    default = false
}

variable "db_edition" {
    description = "DB Edition"
    default = "ENTERPRISE_EDITION_EXTREME_PERFORMANCE"
}

variable "db_admin_password" {
    description = "Database Admin password"
    default=""
}

variable "db_instance_shape" {
    description = "DB Instance shape"
    default="VM.Standard2.2"
}

variable "db_node_count" {
    description = "Number of DB Nodes"
    default = "2"
}
variable "db_size_in_gb" {
    description = "Size of database in GB"
    default="256"
}
variable "db_license_model" {
    description = "Database License model"
    default= "LICENSE_INCLUDED"
}


variable epm_database_backup_config_required {
    description = "Whether private Load balancer"
    default = true
}

variable "epm_database_backup_recovery_window" {
    description = "Database License model"
    default = "30"
}

variable "db_name" {
    description = "Database Name"
    default = "EPMDB"
}

variable "db_characterset" {
    description = "Database Characterset"
    default = "AL32UTF8"
}
variable "db_nls_characterset" {
    description = "Database National Characterset"
    default="AL16UTF16"
}

variable "db_version" {
    description = "Database version"    
    default="12.1.0.2"
}
variable "db_pdb_name" {
    description = "Pluggable database Name"
    default="EPMDB"   
}


# Load Balancer Variables

variable load_balancer_shape {
    description = "Load Balancer shape"
}
variable load_balancer_private {
    description = "Whether private Load balancer"
    default = true
}
variable load_balancer_hostname {
    description = "Load Balancer hostname"
}

variable load_balancer_listen_port {
    description = "Load balancer listen port"
}

variable "timeout" {
  description = "Timeout setting for resource creation"
  default     = "30m"
}

/*
variable "bastion_user" {
  description = "Login user for bastion host"
}
*/
variable epm_shared_filesystem_path {
    default = "E:"
}
variable epm_shared_filesystem_size_limit_in_gb {
    default = "500"
}


variable "platform-images" {
  type = "map"

  default = {
    // See https://docs.cloud.oracle.com/iaas/images/
    // Windows-Server-2016-Standard-Edition-VM-Gen2-2020.01.14-0"
    // https://docs.cloud.oracle.com/en-us/iaas/images/image/43da2ba6-6014-410c-94df-12e1635be25e/

    ap-melbourne-1	    =   "ocid1.image.oc1.ap-melbourne-1.aaaaaaaatdyrmhvyt4bl74oum5gpgevunwatgmpbuqn6jun4r7qbnczcn4dq"
    ap-mumbai-1	        =   "ocid1.image.oc1.ap-mumbai-1.aaaaaaaasc2wsrcxrwdfn4zh6wmdnu4glsynelffdm6xgbjh3ipd5umpx2xa"
    ap-osaka-1	        =   "ocid1.image.oc1.ap-osaka-1.aaaaaaaaobpeuodhowu57rehuhyzxww552hwqseagitt2j4yjh6hbt6z4xbq"
    ap-seoul-1	        =   "ocid1.image.oc1.ap-seoul-1.aaaaaaaak22mo5iuorfuutp65kkjh4qlhn5ixueuwijhshheapyxwbj5xomq"
    ap-sydney-1	        =   "ocid1.image.oc1.ap-sydney-1.aaaaaaaa3ir4nlvogcden7ncm6wgjisr7fyshmqxtavu5vo4rfrb742p3txa"
    ap-tokyo-1	        =   "ocid1.image.oc1.ap-tokyo-1.aaaaaaaaqqe3xlsipnanxvls7sydfchgp34uoh6gs2ymmt3wtvxbbavebwrq"
    ca-toronto-1	    =   "ocid1.image.oc1.ca-toronto-1.aaaaaaaaq44jibkjmdspz3jn7hdc6uzvpgvtwr6ch4za3fq4mxioqfoxqxja"
    eu-amsterdam-1	    =   "ocid1.image.oc1.eu-amsterdam-1.aaaaaaaa27dp74s7gs7f5u7h3jquusq2moq5owfmxarnjhxefodzqgsilqqa"
    eu-frankfurt-1	    =   "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaabgz6uyv4lsvn4n5biimheldf3oqlsv57sgyrqr23y4fga3u553ca"
    eu-zurich-1	        =   "ocid1.image.oc1.eu-zurich-1.aaaaaaaakkzh3flq3etztpviemeuvd3tao7frk6a6qsduazwbvpv7ou4t4ma"
    me-jeddah-1	        =   "ocid1.image.oc1.me-jeddah-1.aaaaaaaabibtjsm5j5xnuxxbtn6uash2iw6s637wwwcpcdddadlvoilksk6a"
    sa-saopaulo-1	    =   "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaahks2snkmp2hqhbudpwmtrkavzm6t5hidb5yznpvvd6xsa4oes6sa"
    uk-gov-london-1	    =   "ocid1.image.oc4.uk-gov-london-1.aaaaaaaa2ibi32nxnlns7k5cxjt34qwgvbcy76to7ugukscuko72j64d4ftq"
    uk-london-1	        =   "ocid1.image.oc1.uk-london-1.aaaaaaaaraiur2saeneruix7avikzgvobacex4a3lkexwurty7iinqgs5kkq"
    us-ashburn-1	    =   "ocid1.image.oc1.iad.aaaaaaaauwpipy7yex62fvqix7a7ipdzdhc6pdz57vkowvc4jhkfrazm6bwa"
    us-langley-1	    =   "ocid1.image.oc2.us-langley-1.aaaaaaaalyvr2r25i757olybmlgzm4723k6lfzkwdroognwr4u7xoko6v7sq"
    us-luke-1	        =   "ocid1.image.oc2.us-luke-1.aaaaaaaapppr45azjlizyjjytxtsues7io2tfaaeflgoyarbo3igp6ksfi4a"
    us-phoenix-1	    =   "ocid1.image.oc1.phx.aaaaaaaan57vn7nfbjtklcc2e46jzylum7d3jnb762erd26evl3xhnvoceya"
  }
}

variable enable_ssl_ports {
    description = "Whether private Load balancer"
    default = false
}

# Bastion host variables

variable "bastion_instance_shape" {
    description = "Instance shape of bastion host"
    default = "VM.Standard2.1"
}
variable "instance_os" {
    description = "Operating system for compute instances"
    default = "Oracle Linux" 
}
variable "linux_os_version" {
    description = "Operating system version for bastion host"
    default = "6.10"
}