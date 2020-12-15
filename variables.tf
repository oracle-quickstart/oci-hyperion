/*Copyright © 2020, Oracle and/or its affiliates.

The Universal Permissive License (UPL), Version 1.0*/

variable "tenancy_ocid" {
}

variable "region" {
}

variable "compartment_ocid" {
}

variable "AD" {
  type    = list(string)
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
  default     = "epmvcn"
}

#Environment prefix to define name of resources
variable "epm_env_prefix" {
  #    default = "epm"
}

#EPM Financial Management Variables
variable "epm_financial_management" {
  description = "Whether private Load balancer"
  default     = false
}

variable "epm_hfm_instance_count" {
  description = "Application Server count"
  default     = "1"
}

variable "epm_hfm_instance_shape" {
  description = "Application Instance shape"
  default     = "VM.Standard2.1"
}

variable "epm_hfm_instance_bv_size_in_gb" {
  description = "Boot volume size of application servers"
  default     = "100"
}

variable "epm_hfm_instance_bv_vpus_per_gb" {
  description = "Boot volume size of application servers"
  default     = "0"
}

#EPM HTP Variables

variable "epm_htp_required" {
  description = "Whether HTP is required"
  default     = false
}

variable "epm_htp_instance_count" {
  description = "Application Server count"
  default     = "1"
}

variable "epm_htp_instance_shape" {
  description = "Application Instance shape"
  default     = "VM.Standard2.1"
}

variable "epm_htp_instance_bv_size_in_gb" {
  description = "Boot volume size of application servers"
  default     = "100"
}

variable "epm_htp_instance_bv_vpus_per_gb" {
  description = "Boot volume size of application servers"
  default     = "0"
}

# EPM Planning Variables 

variable "epm_planning" {
  description = "Whether private Load balancer"
  default     = false
}

variable "epm_planning_instance_count" {
  description = "Application Server count"
  default     = "1"
}

variable "epm_planning_instance_shape" {
  description = "Application Instance shape"
  default     = "VM.Standard2.1"
}

variable "epm_planning_instance_bv_size_in_gb" {
  description = "Boot volume size of application servers"
  default     = "100"
}

variable "epm_planning_instance_bv_vpus_per_gb" {
  description = "Boot volume size of application servers"
  default     = "0"
}

variable "epm_essbase_required" {
  description = "Whether private Load balancer"
  default     = false
}

variable "epm_essbase_instance_count" {
  description = "Application Server count"
  default     = "1"
}

variable "epm_essbase_instance_shape" {
  description = "Application Instance shape"
  default     = "VM.Standard2.1"
}

variable "epm_essbase_instance_bv_size_in_gb" {
  description = "Boot volume size of application servers"
  default     = "100"
}

variable "epm_essbase_instance_bv_vpus_per_gb" {
  description = "Boot volume size of application servers"
  default     = "0"
}

# EPM Foundation Variables
variable "epm_foundation_instance_count" {
  description = "Application Server count"
  default     = "1"
}

variable "epm_foundation_instance_shape" {
  description = "Application Instance shape"
  default     = "VM.Standard2.1"
}

variable "epm_foundation_instance_bv_size_in_gb" {
  description = "Boot volume size of application servers"
  default     = "100"
}

variable "epm_foundation_instance_bv_vpus_per_gb" {
  description = "Boot volume size of application servers"
  default     = "0"
}

# Foundation database
variable "foundation_db_separate" {
  description = "Whether private Load balancer"
  default     = false
}

variable "foundation_db_edition" {
  description = "DB Edition"
  default     = "ENTERPRISE_EDITION_EXTREME_PERFORMANCE"
}

variable "foundation_db_instance_shape" {
  description = "DB Instance shape"
  default     = "VM.Standard2.2"
}

variable "foundation_db_node_count" {
  description = "Number of DB Nodes"
  default     = "2"
}

variable "foundation_db_size_in_gb" {
  description = "Size of database in GB"
  default     = "256"
}

variable "foundation_db_license_model" {
  description = "Database License model"
  default     = "LICENSE_INCLUDED"
}

variable "foundation_db_admin_password" {
  description = "Database Admin password"
  default     = ""
}

variable "foundation_db_name" {
  description = "Database Name"
  default     = "FNDCDB"
}

variable "foundation_db_characterset" {
  description = "Database Characterset"
  default     = "AL32UTF8"
}

variable "foundation_db_nls_characterset" {
  description = "Database National Characterset"
  default     = "AL16UTF16"
}

variable "foundation_db_version" {
  description = "Database version"
  default     = "12.1.0.2"
}

variable "foundation_pdb_name" {
  description = "Pluggable database Name"
  default     = "FNDDB"
}

# Addtional Products
variable "add_additional_products" {
  description = "Whether private Load balancer"
  default     = false
}

# Profitability Variables
variable "epm_profitability_required" {
  description = "Whether private Load balancer"
  default     = false
}

variable "epm_profitability_instance_count" {
  description = "Application Server count"
  default     = "1"
}

variable "epm_profitability_instance_shape" {
  description = "Application Instance shape"
  default     = "VM.Standard2.1"
}

variable "epm_profitability_instance_bv_size_in_gb" {
  description = "Boot volume size of application servers"
  default     = "100"
}

variable "epm_profitability_instance_bv_vpus_per_gb" {
  description = "Boot volume size of application servers"
  default     = "0"
}

# Strategic Finance
variable "epm_strategic_finance_required" {
  description = "Whether private Load balancer"
  default     = false
}

variable "epm_strategic_finance_instance_count" {
  description = "Application Server count"
  default     = "1"
}

variable "epm_strategic_finance_instance_shape" {
  description = "Application Instance shape"
  default     = "VM.Standard2.1"
}

variable "epm_strategic_finance_instance_bv_size_in_gb" {
  description = "Boot volume size of application servers"
  default     = "100"
}

variable "epm_strategic_finance_instance_bv_vpus_per_gb" {
  description = "Boot volume size of application servers"
  default     = "0"
}

# FDMEE
variable "epm_fdmee_required" {
  description = "Whether private Load balancer"
  default     = false
}

variable "epm_fdmee_instance_count" {
  description = "Application Server count"
  default     = "1"
}

variable "epm_fdmee_instance_shape" {
  description = "Application Instance shape"
  default     = "VM.Standard2.1"
}

variable "epm_fdmee_instance_bv_size_in_gb" {
  description = "Boot volume size of application servers"
  default     = "100"
}

variable "epm_fdmee_instance_bv_vpus_per_gb" {
  description = "Boot volume size of application servers"
  default     = "0"
}

# Web Instance
variable "epm_web_instance_count" {
  description = "Application Server count"
  default     = "1"
}

variable "epm_web_instance_shape" {
  description = "Application Instance shape"
  default     = "VM.Standard2.1"
}

variable "epm_web_instance_listen_port" {
  description = "Application instance listen port"
  default     = "19000"
}

variable "epm_web_instance_bv_size_in_gb" {
  description = "Boot volume size of application servers"
  default     = "100"
}

variable "epm_web_instance_bv_vpus_per_gb" {
  description = "Boot volume size of application servers"
  default     = "0"
}

variable "timezone" {
  description = "Set timezone for servers"
  default     = "America/New_York"
}

# Database variables

variable "epm_database_required" {
  description = "Whether private Load balancer"
  default     = false
}

variable "db_edition" {
  description = "DB Edition"
  default     = "ENTERPRISE_EDITION_EXTREME_PERFORMANCE"
}

variable "db_admin_password" {
  description = "Database Admin password"
  default     = ""
}

variable "db_instance_shape" {
  description = "DB Instance shape"
  default     = "VM.Standard2.2"
}

variable "db_node_count" {
  description = "Number of DB Nodes"
  default     = "2"
}

variable "db_size_in_gb" {
  description = "Size of database in GB"
  default     = "256"
}

variable "db_license_model" {
  description = "Database License model"
  default     = "LICENSE_INCLUDED"
}

variable "epm_database_backup_config_required" {
  description = "Whether private Load balancer"
  default     = true
}

variable "epm_database_backup_recovery_window" {
  description = "Database License model"
  default     = "30"
}

variable "db_name" {
  description = "Database Name"
  default     = "EPMDB"
}

variable "db_characterset" {
  description = "Database Characterset"
  default     = "AL32UTF8"
}

variable "db_nls_characterset" {
  description = "Database National Characterset"
  default     = "AL16UTF16"
}

variable "db_version" {
  description = "Database version"
  default     = "12.1.0.2"
}

variable "db_pdb_name" {
  description = "Pluggable database Name"
  default     = "EPMDB"
}

# Load Balancer Variables

variable "load_balancer_shape" {
  description = "Load Balancer shape"
}

variable "load_balancer_private" {
  description = "Whether private Load balancer"
  default     = true
}

variable "load_balancer_hostname" {
  description = "Load Balancer hostname"
}

variable "load_balancer_listen_port" {
  description = "Load balancer listen port"
}

variable "timeout" {
  description = "Timeout setting for resource creation"
  default     = "30m"
}

variable "epm_shared_filesystem_path" {
  type    = string
  default = "E:"
}

variable "epm_shared_filesystem_size_limit_in_gb" {
  default = "500"
}

variable "platform-images" {
  type = map(string)
  // See https://docs.cloud.oracle.com/iaas/images/
  // Windows-Server-2016-Standard-Edition-VM-Gen2-2020.10.20-0
  // https://docs.cloud.oracle.com/en-us/iaas/images/image/943bdefa-8858-4b37-98e0-fd710c4aea1e/

  default = {
    ap-chuncheon-1   = "ocid1.image.oc1.ap-chuncheon-1.aaaaaaaawhz66gb4moh2hu5sjwjmxecezbamlfcl6taxtf6dhn7bzxdbnpxa"
    ap-hyderabad-1   = "ocid1.image.oc1.ap-hyderabad-1.aaaaaaaail6ajbjhhi6t6t4sunosbxq3bcemiqdphjxk4rmiitwmf5l4rjxa"
    ap-melbourne-1   = "ocid1.image.oc1.ap-melbourne-1.aaaaaaaaufuk4kysoc3ot6vchl7f3akaxue2f7equmqjrr5zloucx4mcyj7q"
    ap-mumbai-1      = "ocid1.image.oc1.ap-mumbai-1.aaaaaaaahsuza3dhs24dkv2vhcwdigtwtwrxr3z2m6bbx4jlfsqagaprvpqq"
    ap-osaka-1       = "ocid1.image.oc1.ap-osaka-1.aaaaaaaaruqfgcfrfwstvzjjludk3h4ixgypnlrmudflriji5npblawqtwma"
    ap-seoul-1       = "ocid1.image.oc1.ap-seoul-1.aaaaaaaa7vox5k3y6gv7pvipoq6lw3h7owtndwi7o43vconu4aiejw7ni37a"
    ap-sydney-1      = "ocid1.image.oc1.ap-sydney-1.aaaaaaaae3zbwp6dbvqykhai767as2ea4u5th2glpaysn2glpykhgbr4lqjq"
    ap-tokyo-1       = "ocid1.image.oc1.ap-tokyo-1.aaaaaaaayy6m7j4ysvfhzoc6dqbs3wk42dwhpaux2c352fjz4ox2ugems5rq"
    ca-montreal-1    = "ocid1.image.oc1.ca-montreal-1.aaaaaaaa6liu7nqmfcekgbb4dnntibno6zrdlhunpau4aewihehrpjdtz5kq"
    ca-toronto-1     = "ocid1.image.oc1.ca-toronto-1.aaaaaaaa3d3zukg7abchkslkczxjq3kyqjxu53vqwbmrihbr5ptkvvijjina"
    eu-amsterdam-1   = "ocid1.image.oc1.eu-amsterdam-1.aaaaaaaaxqyf6ivisdywnqtgvnxgttvoxoh5s3k7bftwuala5e2gto4dhhja"
    eu-frankfurt-1   = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaaqbo4gkjxudu7n55atu6vvzmvrhgqy7oizqnvm7xr6tmkoovtnsea"
    eu-zurich-1      = "ocid1.image.oc1.eu-zurich-1.aaaaaaaaproumsjinhf224btfutzkpzsavk2pmfrhv3n65u5mwdrcrpyjpyq"
    me-dubai-1       = "ocid1.image.oc1.me-dubai-1.aaaaaaaau2jquf2qzqurd7xe6ltyqpjgzfki553cckhwtf4r6ljrh3asdqcq"
    me-jeddah-1      = "ocid1.image.oc1.me-jeddah-1.aaaaaaaaoozh2bxbihy62ibnqqmmfow3s5n54lt5527pozi2lfcmpcwxfwfa"
    sa-saopaulo-1    = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaau3yqhnvryt6ccvqq5bpxomxzvrrcldvkjxvtezwpikci5vhiykpa"
    uk-cardiff-1     = "ocid1.image.oc1.uk-cardiff-1.aaaaaaaasub56y5phhmbhfi6o4f4kztum4epgugxzmfwpcp2xnxxq5vq7tva"
    uk-london-1      = "ocid1.image.oc1.uk-london-1.aaaaaaaaw47u3ev4rs5wfijxcvmy436qw7digrl6pnjkfiohzdl35kny7geq"
    us-ashburn-1     = "ocid1.image.oc1.iad.aaaaaaaa74rl4tzxblzk2sqm43k62srh6bv4hbxkkewlbyar6ximerilowyq"
    us-gov-ashburn-1 = "ocid1.image.oc3.us-gov-ashburn-1.aaaaaaaa2aejmo3ne6makljm2tuz4irk4n2ea5vsef64x6cennfmywavf7da"
    us-gov-chicago-1 = "ocid1.image.oc3.us-gov-chicago-1.aaaaaaaauhnqpjaakxngvpgaxknszilhioiwoa4dgi2ubkahtzcznmmcmjla"
    us-gov-phoenix-1 = "ocid1.image.oc3.us-gov-phoenix-1.aaaaaaaa7qoxo5w7hsmp2seaquqf7nfloitaf3g7yasuul26yctxg3axu7ia"
    us-langley-1     = "ocid1.image.oc2.us-langley-1.aaaaaaaarpaupho6gwoosc7ji5sazomf3g554brb6ed6ibbq7dnqud363hyq"
    us-luke-1        = "ocid1.image.oc2.us-luke-1.aaaaaaaakcw3h2gnygjjdr44fj6vypksvgq6sryewsvquboyziyb3x6rl7va"
    us-phoenix-1     = "ocid1.image.oc1.phx.aaaaaaaapctdmxecnpf2wroha66eaftl6gnmoxq5xmzwr4p5ya6mtmmxzpma"
    us-sanjose-1     = "ocid1.image.oc1.us-sanjose-1.aaaaaaaa42q7anlfqaio2htxakdadtxvsrqk4tleisi2gh2ei3isyn7ov5aq"
  }
}

variable "enable_ssl_ports" {
  description = "Whether private Load balancer"
  default     = false
}

# Bastion host variables

variable "bastion_instance_shape" {
  description = "Instance shape of bastion host"
  default     = "VM.Standard2.1"
}

variable "instance_os" {
  description = "Operating system for compute instances"
  default     = "Oracle Linux"
}

variable "linux_os_version" {
  description = "Operating system version for bastion host"
  default     = "6.10"
}

variable "freeform_tags" {
  type = map(any)
  default = {
    environment = "dev"
  }
}