/*Copyright © 2020, Oracle and/or its affiliates.

The Universal Permissive License (UPL), Version 1.0*/


locals {
  tcp_protocol  = "6"
  udp_protocol  = "17"
  all_protocols = "all"
  anywhere      = "0.0.0.0/0"
  db_port       = "1521"
  ssh_port      = "22"
  rdp_port      = "3389"
#  winrm_port    = "5986"
  fss_ports     = ["2048","2050","111"]
  
  epm_hfm_ports_non_ssl = ["7001", "7363", "9091"]
  epm_hfm_ports_ssl = ["7001", "7365", "9092"]
  
  epm_planning_ports_non_ssl = ["7001", "8300", "11333"]
  epm_planning_ports_ssl = ["7001", "8343", "11333"]
  
  epm_essbase_ports_non_ssl = ["1423", "32768", "33768", "6711", "6712"]
  epm_essbase_ports_ssl = ["6423", "32768", "33768", "6711", "6712"]

  epm_foundation_ports_non_ssl = ["7001","9000", "5251", "5255", "6860", "6861"]
  epm_foundation_ports_ssl = ["7001", "9443", "5251", "5255", "6860", "6861"]

  epm_htp_ports_non_ssl = ["22200"]
  epm_htp_ports_ssl = ["23243"]

  epm_fdmee_ports_non_ssl = ["6550"]
  epm_fdmee_ports_ssl = ["6553"]

  epm_strategic_finance_ports_non_ssl = ["8900"]
  epm_strategic_finance_ports_ssl = ["8943"]

  epm_profitability_ports_non_ssl = ["6756"]
  epm_profitability_ports_ssl = ["6743"]

  epm_web_ports_ssl = ["19000"]
}

# Bastion Security List
resource "oci_core_security_list" "BastionSecList" {
    compartment_id  = "${var.compartment_ocid}"
    display_name    = "BastionSecList"
    vcn_id          = "${module.create_vcn.vcnid}"

    egress_security_rules = [
        {
        tcp_options {
            "min" = "${local.rdp_port}"
            "max" = "${local.rdp_port}"
        }
        protocol    = "${local.tcp_protocol}"
        destination = "${var.vcn_cidr}"
        },
        {
        tcp_options {
            "min" = "${local.ssh_port}"
            "max" = "${local.ssh_port}"
        }
        protocol    = "${local.tcp_protocol}"
        destination = "${var.vcn_cidr}"
        },
    ]

    ingress_security_rules = [
        {
        tcp_options {
            "min" = "${local.ssh_port}"
            "max" = "${local.ssh_port}"
        }

        protocol = "${local.tcp_protocol}"
        source   = "${local.anywhere}"
        },
    ]
}


# Database System Security List
resource "oci_core_security_list" "DBSecList" {
    compartment_id  = "${var.compartment_ocid}"
    display_name    = "DBSecList"
    vcn_id          = "${module.create_vcn.vcnid}"

    egress_security_rules = [
        {
        protocol    = "${local.tcp_protocol}"
        destination = "${local.anywhere}"
        },
    ]

    ingress_security_rules = [
        {
        tcp_options {
            "min" = "${local.ssh_port}"
            "max" = "${local.ssh_port}"
        }

        protocol = "${local.tcp_protocol}"
        source   = "${var.vcn_cidr}"
        },
        {
        tcp_options {
            "min" = "${local.db_port}"
            "max" = "${local.db_port}"
        }

        protocol = "${local.tcp_protocol}"
        source   = "${var.vcn_cidr}"
        },
    ]
}

# Application Server Security List
resource "oci_core_security_list" "AppSecList" {
    compartment_id  = "${var.compartment_ocid}"
    display_name    = "AppSecList"
    vcn_id          = "${module.create_vcn.vcnid}"

    egress_security_rules = [
        {
        protocol    = "${local.tcp_protocol}"
        destination = "${local.anywhere}"
        },
        {
        tcp_options {
            source_port_range {
                #Required
                min = "${local.fss_ports[0]}"
                max = "${local.fss_ports[1]}"
            }
        }

        protocol        = "${local.tcp_protocol}"
        destination     = "${var.vcn_cidr}"
        },
        {
        tcp_options {
            source_port_range {
                #Required
                min = "${local.fss_ports[2]}"
                max = "${local.fss_ports[2]}"
            }
        }

        protocol        = "${local.tcp_protocol}"
        destination     = "${var.vcn_cidr}"
        },
        {
        udp_options {
            source_port_range {
                #Required
                min = "${local.fss_ports[2]}"
                max = "${local.fss_ports[2]}"
            }        
        }

        protocol        = "${local.udp_protocol}"
        destination     = "${var.vcn_cidr}"
        }       
    ]

    ingress_security_rules = [
        {
        tcp_options {
            "min" = "${local.rdp_port}"
            "max" = "${local.rdp_port}"
        }

        protocol = "${local.tcp_protocol}"
        source   = "${var.vcn_cidr}"
        },
        {
        tcp_options {
            "min" = "${var.enable_ssl_ports == "True" ? local.epm_foundation_ports_ssl[0] : local.epm_foundation_ports_non_ssl[0]}"
            "max" = "${var.enable_ssl_ports == "True" ? local.epm_foundation_ports_ssl[0] : local.epm_foundation_ports_non_ssl[0]}"
        }

        protocol = "${local.tcp_protocol}"
        source   = "${var.vcn_cidr}"
        description = "EPM Foundation Server Weblogic port"
        },
        {
        tcp_options {
            "min" = "${var.enable_ssl_ports == "True" ? local.epm_foundation_ports_ssl[1] : local.epm_foundation_ports_non_ssl[1]}"
            "max" = "${var.enable_ssl_ports == "True" ? local.epm_foundation_ports_ssl[1] : local.epm_foundation_ports_non_ssl[1]}"
        }

        protocol = "${local.tcp_protocol}"
        source   = "${var.vcn_cidr}"
        description = "EPM Foundation Server Managed Server port"
        },
        {
        tcp_options {
            "min" = "${var.enable_ssl_ports == "True" ? local.epm_foundation_ports_ssl[2] : local.epm_foundation_ports_non_ssl[2]}"
            "max" = "${var.enable_ssl_ports == "True" ? local.epm_foundation_ports_ssl[2] : local.epm_foundation_ports_non_ssl[2]}"
        }

        protocol = "${local.tcp_protocol}"
        source   = "${var.vcn_cidr}"
        description = "EPM Foundation Server Dimension Server port"
        },
        {
        tcp_options {
            "min" = "${var.enable_ssl_ports == "True" ? local.epm_foundation_ports_ssl[3] : local.epm_foundation_ports_non_ssl[3]}"
            "max" = "${var.enable_ssl_ports == "True" ? local.epm_foundation_ports_ssl[3] : local.epm_foundation_ports_non_ssl[3]}"
        }

        protocol = "${local.tcp_protocol}"
        source   = "${var.vcn_cidr}"
        description = "EPM Foundation Server Dimension Server JNI Bridge port"
        },
        {
        tcp_options {
            "min" = "${var.enable_ssl_ports == "True" ? local.epm_foundation_ports_ssl[4] : local.epm_foundation_ports_non_ssl[4]}"
            "max" = "${var.enable_ssl_ports == "True" ? local.epm_foundation_ports_ssl[4] : local.epm_foundation_ports_non_ssl[4]}"
        }

        protocol = "${local.tcp_protocol}"
        source   = "${var.vcn_cidr}"
        description = "EPM Foundation Server Reporting and Analysis Framework Agent Port"
        },
        {
        tcp_options {
            "min" = "${var.enable_ssl_ports == "True" ? local.epm_foundation_ports_ssl[5] : local.epm_foundation_ports_non_ssl[5]}"
            "max" = "${var.enable_ssl_ports == "True" ? local.epm_foundation_ports_ssl[5] : local.epm_foundation_ports_non_ssl[5]}"
        }

        protocol = "${local.tcp_protocol}"
        source   = "${var.vcn_cidr}"
        description = "EPM Foundation Server Reporting and Analysis Framework Agent Port"
        },
        {
        tcp_options {
            "min" = "${var.enable_ssl_ports == "True" ? local.epm_planning_ports_ssl[0] : local.epm_planning_ports_non_ssl[0]}"
            "max" = "${var.enable_ssl_ports == "True" ? local.epm_planning_ports_ssl[0] : local.epm_planning_ports_non_ssl[0]}"
        }

        protocol = "${local.tcp_protocol}"
        source   = "${var.vcn_cidr}"
        description = "EPM Planning Server Weblogic port"
        },
        {
        tcp_options {
            "min" = "${var.enable_ssl_ports == "True" ? local.epm_planning_ports_ssl[1] : local.epm_planning_ports_non_ssl[1]}"
            "max" = "${var.enable_ssl_ports == "True" ? local.epm_planning_ports_ssl[1] : local.epm_planning_ports_non_ssl[1]}"
        }

        protocol = "${local.tcp_protocol}"
        source   = "${var.vcn_cidr}"
        description = "EPM Planning Java Web application ports"
        },
        {
        tcp_options {
            "min" = "${var.enable_ssl_ports == "True" ? local.epm_planning_ports_ssl[2] : local.epm_planning_ports_non_ssl[2]}"
            "max" = "${var.enable_ssl_ports == "True" ? local.epm_planning_ports_ssl[2] : local.epm_planning_ports_non_ssl[2]}"
        }

        protocol = "${local.tcp_protocol}"
        source   = "${var.vcn_cidr}"
        description = "EPM Planning RMI port"
        },
        {
        tcp_options {
            "min" = "${var.enable_ssl_ports == "True" ? local.epm_essbase_ports_ssl[0] : local.epm_essbase_ports_non_ssl[0]}"
            "max" = "${var.enable_ssl_ports == "True" ? local.epm_essbase_ports_ssl[0] : local.epm_essbase_ports_non_ssl[0]}"
        }

        protocol = "${local.tcp_protocol}"
        source   = "${var.vcn_cidr}"
        description = "EPM Essbase Server Agent port"
        },
        {
        tcp_options {
            "min" = "${var.enable_ssl_ports == "True" ? local.epm_essbase_ports_ssl[1] : local.epm_essbase_ports_non_ssl[1]}"
            "max" = "${var.enable_ssl_ports == "True" ? local.epm_essbase_ports_ssl[2] : local.epm_essbase_ports_non_ssl[2]}"
        }

        protocol = "${local.tcp_protocol}"
        source   = "${var.vcn_cidr}"
        description = "EPM Essbase Server Agent port"
        },
        {
        tcp_options {
            "min" = "${var.enable_ssl_ports == "True" ? local.epm_essbase_ports_ssl[3] : local.epm_essbase_ports_non_ssl[3]}"
            "max" = "${var.enable_ssl_ports == "True" ? local.epm_essbase_ports_ssl[4] : local.epm_essbase_ports_non_ssl[4]}"
        }

        protocol = "${local.tcp_protocol}"
        source   = "${var.vcn_cidr}"
        description = "EPM Essbase OPMN port"
        },
        {
        tcp_options {
            "min" = "${var.enable_ssl_ports == "True" ? local.epm_hfm_ports_ssl[0] : local.epm_hfm_ports_non_ssl[0]}"
            "max" = "${var.enable_ssl_ports == "True" ? local.epm_hfm_ports_ssl[0] : local.epm_hfm_ports_non_ssl[0]}"
        }

        protocol = "${local.tcp_protocol}"
        source   = "${var.vcn_cidr}"
        description = "EPM Financial Management Server Weblogic port"
        },
        {
        tcp_options {
            "min" = "${var.enable_ssl_ports == "True" ? local.epm_hfm_ports_ssl[1] : local.epm_hfm_ports_non_ssl[1]}"
            "max" = "${var.enable_ssl_ports == "True" ? local.epm_hfm_ports_ssl[1] : local.epm_hfm_ports_non_ssl[1]}"
        }

        protocol = "${local.tcp_protocol}"
        source   = "${var.vcn_cidr}"
        description = "EPM Financial Management Server Managed Server port"
        },
        {
        tcp_options {
            "min" = "${var.enable_ssl_ports == "True" ? local.epm_hfm_ports_ssl[2] : local.epm_hfm_ports_non_ssl[2]}"
            "max" = "${var.enable_ssl_ports == "True" ? local.epm_hfm_ports_ssl[2] : local.epm_hfm_ports_non_ssl[2]}"
        }

        protocol = "${local.tcp_protocol}"
        source   = "${var.vcn_cidr}"
        description = "EPM Financial Management Server port"
        },

        {
        tcp_options {
            "min" = "${var.enable_ssl_ports == "True" ? local.epm_htp_ports_ssl[0] : local.epm_htp_ports_non_ssl[0]}"
            "max" = "${var.enable_ssl_ports == "True" ? local.epm_htp_ports_ssl[0] : local.epm_htp_ports_non_ssl[0]}"
        }

        protocol = "${local.tcp_protocol}"
        source   = "${var.vcn_cidr}"
        description = "EPM HTP Server port"
        },
        {
        tcp_options {
           "min" = "${var.enable_ssl_ports == "True" ? local.epm_profitability_ports_ssl[0] : local.epm_profitability_ports_non_ssl[0]}"
           "max" = "${var.enable_ssl_ports == "True" ? local.epm_profitability_ports_ssl[0] : local.epm_profitability_ports_non_ssl[0]}"
        }

        protocol = "${local.tcp_protocol}"
        source   = "${var.vcn_cidr}"
        description = "EPM Profitability Server port"
        },
        {
        tcp_options {
           "min" = "${var.enable_ssl_ports == "True" ? local.epm_fdmee_ports_ssl[0] : local.epm_fdmee_ports_non_ssl[0]}"
           "max" = "${var.enable_ssl_ports == "True" ? local.epm_fdmee_ports_ssl[0] : local.epm_fdmee_ports_non_ssl[0]}"

        }

        protocol = "${local.tcp_protocol}"
        source   = "${var.vcn_cidr}"
        description = "EPM FDMEE Server port"
        },
        {
        tcp_options {
           "min" = "${var.enable_ssl_ports == "True" ? local.epm_strategic_finance_ports_ssl[0] : local.epm_strategic_finance_ports_non_ssl[0]}"
           "max" = "${var.enable_ssl_ports == "True" ? local.epm_strategic_finance_ports_ssl[0] : local.epm_strategic_finance_ports_non_ssl[0]}"

        }

        protocol = "${local.tcp_protocol}"
        source   = "${var.vcn_cidr}"
        description = "EPM Strategic Finance Server port"
        },
        {
        tcp_options {
            "min" = "${local.fss_ports[0]}"
            "max" = "${local.fss_ports[1]}"
        }

        protocol = "${local.tcp_protocol}"
        source   = "${var.vcn_cidr}"
        },
        {
        tcp_options {
            "min" = "${local.fss_ports[2]}"
            "max" = "${local.fss_ports[2]}"
        }

        protocol = "${local.tcp_protocol}"
        source   = "${var.vcn_cidr}"
        },
        {
        udp_options {
            "min" = "${local.fss_ports[0]}"
            "max" = "${local.fss_ports[0]}"
        }

        protocol = "${local.udp_protocol}"
        source   = "${var.vcn_cidr}"
        },
        {
        udp_options {
            "min" = "${local.fss_ports[2]}"
            "max" = "${local.fss_ports[2]}"
        }

        protocol = "${local.udp_protocol}"
        source   = "${var.vcn_cidr}"
        },
    ]
}


# Load Balancer Security List
resource "oci_core_security_list" "WebSecList" {
    compartment_id  = "${var.compartment_ocid}"
    display_name    = "WebSecList"
    vcn_id          = "${module.create_vcn.vcnid}"

    egress_security_rules = [
        {
        protocol    = "${local.tcp_protocol}"
        destination = "${local.anywhere}"
        },
    ]

    ingress_security_rules = [
        {
        tcp_options {
            "min" = "${var.epm_web_instance_listen_port}"
            "max" = "${var.epm_web_instance_listen_port}"
        }

        protocol = "${local.tcp_protocol}"
        source   = "${var.vcn_cidr}"
        },
    ]
}

# Load Balancer Security List
resource "oci_core_security_list" "LBSecList" {
    compartment_id  = "${var.compartment_ocid}"
    display_name    = "LBSecList"
    vcn_id          = "${module.create_vcn.vcnid}"

    egress_security_rules = [
        {
        protocol    = "${local.tcp_protocol}"
        destination = "${local.anywhere}"
        },
    ]

    ingress_security_rules = [
        {
        tcp_options {
            "min" = "${var.load_balancer_listen_port}"
            "max" = "${var.load_balancer_listen_port}"
        }

        protocol = "${local.tcp_protocol}"
        source   = "${local.anywhere}"
        },
    ]
}


