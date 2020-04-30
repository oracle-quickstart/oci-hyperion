#Copyright © 2020, Oracle and/or its affiliates.
#The Universal Permissive License (UPL), Version 1.0

# AD (Availability Domain to use for creating EPM infrastructure) 
# # For single AD regions (ap-seoul-1, ap-tokyo-1, ca-toronto-1), use AD = ["1"] 
AD = "[<Availability domains in double quotes separated by commas>]"

# CIDR block of VCN to be created
vcn_cidr = "<CIDR of VCN>"

# DNS label of VCN to be created
vcn_dns_label = "<DNS of VCN>"

#Environment prefix to define name of resources
epm_env_prefix = "<Environment prefix>"

#----------- EPM Financial Management Configuration ------------------------
# Whether create infrastructure for EPM Financial Management
epm_financial_management = "<true/false>"

# Number of Financial Management instances
epm_hfm_instance_count = "<Number of Financial Management nodes>"

# Shape of Financial Management instance
epm_hfm_instance_shape =  "<Shape of Financial Management node>"

# Block volume size of Financial Management instance
epm_hfm_instance_bv_size_in_gb =  "<Block volume size in gb>"

# Block volume VPUs per GB 
epm_hfm_instance_bv_vpus_per_gb = "<Block volume vpus per gb>"

# Whether create infrastructure for Hyperion Tax Planning with Financial Management
epm_htp_required = "<true/false>"

# Number of Hyperion Tax Provision instances
epm_htp_instance_count = "<Number of Hyperion tax Provision nodes>"

# Shape of Hyperion Tax Provision instance
epm_htp_instance_shape =  "<Shape of Hyperion Tax Provision node>"

# Block volume size of Hyperion Tax Provision instance
epm_htp_instance_bv_size_in_gb =  "<Block volume size in gb>"

# Block volume VPUs per GB 
epm_htp_instance_bv_vpus_per_gb = "<Block volume vpus per gb>"
#---------------------------------------------------------------------------

#----------- EPM Planning Configuration ------------------------------------
# Whether create infrastructure for EPM Planning
epm_planning = "<true/false>"

# Number of EPM Planning instances
epm_planning_instance_count = "<Number of Planning nodes>"

# Shape of EPM Planning instance
epm_planning_instance_shape =  "<Shape of Planning node>"

# Block volume size of EPM Planning instance
epm_planning_instance_bv_size_in_gb =  "<Block volume size in gb>"

# Block volume VPUs per GB
epm_planning_instance_bv_vpus_per_gb = "<Block volume vpus per gb>"

# Number of EPM Essbase instances
epm_essbase_instance_count = "<Number of Essbase nodes>"

# Shape of EPM Essbase instance
epm_essbase_instance_shape =  "<Shape of Essbase node>"

# Block volume size of EPM Essbase instance
epm_essbase_instance_bv_size_in_gb =  "<Block volume size in gb>"

# Block volume VPUs per GB
epm_essbase_instance_bv_vpus_per_gb = "0"
#---------------------------------------------------------------------------

#----------- EPM Foundation Configuration ----------------------------------
# Number of EPM Foundation instances
epm_foundation_instance_count = "<Number of Foundation nodes>"

# Shape of EPM Foundation instance
epm_foundation_instance_shape =  "<Shape of Foundation node>"

# Block volume size of EPM Foundation instance
epm_foundation_instance_bv_size_in_gb =  "<Block volume size in gb>"

# Block volume VPUs per GB
epm_foundation_instance_bv_vpus_per_gb = "<Block volume vpus per gb>"

# Whether create separate database for Foundation services
foundation_db_separate = "<true/false>"

# Foundation services database edition
foundation_db_edition = "<Database Edition>"

# Licensing model for Foundation services database
foundation_db_license_model = "<Database license model>"

# Database version for Foundation services database
foundation_db_version =  "<Database version>"

# Number of database nodes for Foundation services database
foundation_db_node_count =  "<Number of database Nodes (1 for  Single instance and 2 for RAC)>"

# Database Name for Foundation services database 
foundation_db_name =  "<Foundation CDB Name>"

# PDB Name for Foundation services database 
foundation_pdb_name =  "<Foundation PDB Name>"

# DB admin password for Foundation services database
foundation_db_admin_password =  "<Database sys password>"

#Shape of Database nodes for Foundation services
foundation_db_instance_shape =  "<Database node shape>"

#Size of Database
foundation_db_size_in_gb = "<Data size in GB>"

# Characterset of database
foundation_db_characterset = "<Database characterset>"

# National Characterset of database
foundation_db_nls_characterset = "<Database National characterset>"

#---------------------------------------------------------------------------

#----------- EPM Additional Products Configuration ------------------------
# Whether create infrastructure for addtional products
add_additional_products = "<true/false>"

# Whether create infrastructure for EPM Profitability
epm_profitability_required = "<true/false>"

# Number of Profitability instances
epm_profitability_instance_count = "<Number of Profitability nodes>"

# Shape of Profitability instance
epm_profitability_instance_shape =  "<Shape of Profitability node>"

# Block volume size of Profitability instance
epm_profitability_instance_bv_size_in_gb =  "<Block volume size in gb>"

# Block volume VPUs per GB
epm_profitability_instance_bv_vpus_per_gb = "<Block volume vpus per gb>"

####### EPM Strategic Finance Instance  ################

# Whether create infrastructure for Strategic Finance
epm_strategic_finance_required = "<true/false>"

# Number of Strategic Finance instances
epm_strategic_finance_instance_count = "<Number of Strategic Finance nodes>"

# Shape of Strategic Finance instance
epm_strategic_finance_instance_shape =  "<Shape of Strategic Finance node>"

# Block volume size of Strategic Finance instance
epm_strategic_finance_instance_bv_size_in_gb =  "<Block volume size in gb>"

# Block volume VPUs per GB
epm_strategic_finance_instance_bv_vpus_per_gb = "<Block volume vpus per gb>"

####### EPM FDMEE Instance  ##############################
# Whether create infrastructure for FDMEE 
epm_fdmee_required = "<true/false>"

# Number of FDMEE instances
epm_fdmee_instance_count = "<Number of FDMEE nodes>"

# Shape of FDMEE instance
epm_fdmee_instance_shape =   "<Shape of FDMEE node>"

# Block volume size of FDMEE instance
epm_fdmee_instance_bv_size_in_gb =  "<Block volume size in gb>"

# Block volume VPUs per GB
epm_fdmee_instance_bv_vpus_per_gb = "<Block volume vpus per gb>"

#---------------------------------------------------------------------------

#----------- EPM Web Configuration ------------------------
# Number of web instances
epm_web_instance_count = "<Number of Web nodes>"

# Shape of web instance
epm_web_instance_shape =  "<Shape of Web node>"

# Listen port range of web instance
epm_web_instance_listen_port = "<Web Instance Listener port>"

# Block volume size of web instance
epm_web_instance_bv_size_in_gb =  "<Block volume size in gb>"

# Block volume VPUs per GB
epm_web_instance_bv_vpus_per_gb = "<Block volume vpus per gb>"

#---------------------------------------------------------------------------

#----------- EPM Database Configuration ------------------------
####### EPM Hyperion Database ###########################

epm_database_required = "<true/false>"

#epm_database_backup_config_required = "true"

#epm_database_backup_recovery_window = "30"

# Database Edition
db_edition = "<Database Edition>"

# Licensing model for database
db_license_model = "<Database license model>"

# Database version
db_version =  "<Database version>"

# Number of database nodes
db_node_count =  "<Number of database Nodes (1 for  Single instance and 2 for RAC)>"

#Shape of Database nodes
db_instance_shape =  "<Database node shape>"

#Database name
db_name =  "<EPM Database PDB Name>"

# Pluggable database name
db_pdb_name = "<EPM Database PDB Name>"

#Size of Database
db_size_in_gb = "<Data size in GB>"

# Database administration (sys) password
db_admin_password = "<Database sys password>"

# Characterset of database
db_characterset = "<Database characterset>"

# National Characterset of database
db_nls_characterset = "<Database National characterset>"


#---------------------------------------------------------------------------

#----------- EPM Load Balancer Configuration ------------------------

# Whether private load balancer is required
load_balancer_private = "<true/false>"

# Hostname of Load Balancer
load_balancer_hostname =  "<Load balancer hostname>"

# Shape of Load Balancer
load_balancer_shape = "<Load Balancer shape>"

#Listen port of load balancer
load_balancer_listen_port =  "<Load balancer listen port>"

#---------------------------------------------------------------------------
