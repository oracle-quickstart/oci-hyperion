/*Copyright © 2020, Oracle and/or its affiliates.

The Universal Permissive License (UPL), Version 1.0*/

# Virtual Cloud Network (VCN)
resource "oci_core_virtual_network" "vcn" {
  compartment_id = var.compartment_ocid
  cidr_block     = var.vcn_cidr
  dns_label      = var.vcn_dns_label
  display_name   = var.vcn_dns_label
}

# Internet Gateway
resource "oci_core_internet_gateway" "igw" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.vcn.id
  display_name   = "${var.vcn_dns_label}igw"
}

# NAT (Network Address Translation) Gateway
resource "oci_core_nat_gateway" "natgtw" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.vcn.id
  display_name   = "${var.vcn_dns_label}natgtw"
}

# Service Gateway
resource "oci_core_service_gateway" "svcgtw" {
  compartment_id = var.compartment_ocid

  services {
    service_id = data.oci_core_services.svcgtw_services.services[0]["id"]
  }
  vcn_id       = oci_core_virtual_network.vcn.id
  display_name = "${var.vcn_dns_label}svcgtw"
}

/*
# Dynamic Routing Gateway (DRG)
resource "oci_core_drg" "drg" {
  compartment_id  = "${var.compartment_ocid}"
  display_name    = "${var.vcn_dns_label}drg"
}
resource "oci_core_drg_attachment" "drg_attachment" {
  drg_id        = "${oci_core_drg.drg.id}"
  vcn_id        = "${oci_core_virtual_network.vcn.id}"
  display_name  = "${var.vcn_dns_label}drgattchmt"
}
*/

locals {
  tcp_protocol  = "6"
  udp_protocol  = "17"
  all_protocols = "all"
  anywhere      = "0.0.0.0/0"
  db_port       = "1521"
  ssh_port      = "22"
  rdp_port      = "3389"

  #  winrm_port    = "5986"
  fss_ports = ["2048", "2050", "111"]

  epm_hfm_ports_non_ssl = ["7001", "7363", "9091"]
  epm_hfm_ports_ssl     = ["7001", "7365", "9092"]

  epm_planning_ports_non_ssl = ["7001", "8300", "11333"]
  epm_planning_ports_ssl     = ["7001", "8343", "11333"]

  epm_essbase_ports_non_ssl = ["1423", "32768", "33768", "6711", "6712"]
  epm_essbase_ports_ssl     = ["6423", "32768", "33768", "6711", "6712"]

  epm_foundation_ports_non_ssl = ["7001", "9000", "5251", "5255", "6860", "6861"]
  epm_foundation_ports_ssl     = ["7001", "9443", "5251", "5255", "6860", "6861"]

  epm_htp_ports_non_ssl = ["22200"]
  epm_htp_ports_ssl     = ["23243"]

  epm_fdmee_ports_non_ssl = ["6550"]
  epm_fdmee_ports_ssl     = ["6553"]

  epm_strategic_finance_ports_non_ssl = ["8900"]
  epm_strategic_finance_ports_ssl     = ["8943"]

  epm_profitability_ports_non_ssl = ["6756"]
  epm_profitability_ports_ssl     = ["6743"]

  epm_web_ports_ssl = ["19000"]
}

# Public Route Table
resource "oci_core_route_table" "PublicRT" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.vcn.id
  display_name   = "${var.vcn_dns_label}pubrt"
  freeform_tags  = var.freeform_tags
  route_rules {
    network_entity_id = oci_core_internet_gateway.igw.id
    description       = "Route rule for Internet Traffic"
    destination_type  = "CIDR_BLOCK"
    destination       = local.anywhere
  }
}

# Private Route Table
resource "oci_core_route_table" "PrivateRT" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.vcn.id
  display_name   = "${var.vcn_dns_label}pvtrt"
  freeform_tags  = var.freeform_tags
  route_rules {
    network_entity_id = oci_core_nat_gateway.natgtw.id
    description       = "Route rule for Nat gateway"
    destination_type  = "CIDR_BLOCK"
    destination       = local.anywhere
  }
  route_rules {
    network_entity_id = oci_core_service_gateway.svcgtw.id
    description       = "Route rule for Service Gateway"
    destination_type  = "SERVICE_CIDR_BLOCK"
    destination       = data.oci_core_services.svcgtw_services.services[0].cidr_block
  }
}

# Bastion Security List
resource "oci_core_security_list" "BastionSecList" {
  compartment_id = var.compartment_ocid
  display_name   = "BastionSecList"
  vcn_id         = oci_core_virtual_network.vcn.id

  egress_security_rules {
    tcp_options {
      min = local.rdp_port
      max = local.rdp_port
    }
    protocol    = local.tcp_protocol
    destination = var.vcn_cidr
  }
  egress_security_rules {
    tcp_options {
      min = local.ssh_port
      max = local.ssh_port
    }
    protocol    = local.tcp_protocol
    destination = var.vcn_cidr
  }

  ingress_security_rules {
    tcp_options {
      min = local.ssh_port
      max = local.ssh_port
    }

    protocol = local.tcp_protocol
    source   = local.anywhere
  }
}

# Database System Security List
resource "oci_core_security_list" "DBSecList" {
  compartment_id = var.compartment_ocid
  display_name   = "DBSecList"
  vcn_id         = oci_core_virtual_network.vcn.id

  egress_security_rules {
    protocol    = local.tcp_protocol
    destination = local.anywhere
  }

  ingress_security_rules {
    tcp_options {
      min = local.ssh_port
      max = local.ssh_port
    }

    protocol = local.tcp_protocol
    source   = var.vcn_cidr
  }
  ingress_security_rules {
    tcp_options {
      min = local.db_port
      max = local.db_port
    }

    protocol = local.tcp_protocol
    source   = var.vcn_cidr
  }
}

# Application Server Security List
resource "oci_core_security_list" "AppSecList" {
  compartment_id = var.compartment_ocid
  display_name   = "AppSecList"
  vcn_id         = oci_core_virtual_network.vcn.id

  egress_security_rules {
    protocol    = local.tcp_protocol
    destination = local.anywhere
  }
  egress_security_rules {
    tcp_options {
      source_port_range {
        #Required
        min = local.fss_ports[0]
        max = local.fss_ports[1]
      }
    }

    protocol    = local.tcp_protocol
    destination = var.vcn_cidr
  }
  egress_security_rules {
    tcp_options {
      source_port_range {
        #Required
        min = local.fss_ports[2]
        max = local.fss_ports[2]
      }
    }

    protocol    = local.tcp_protocol
    destination = var.vcn_cidr
  }
  egress_security_rules {
    udp_options {
      source_port_range {
        #Required
        min = local.fss_ports[2]
        max = local.fss_ports[2]
      }
    }

    protocol    = local.udp_protocol
    destination = var.vcn_cidr
  }

  ingress_security_rules {
    tcp_options {
      min = local.rdp_port
      max = local.rdp_port
    }

    protocol = local.tcp_protocol
    source   = var.vcn_cidr
  }
  ingress_security_rules {
    tcp_options {
      min = var.enable_ssl_ports == "True" ? local.epm_foundation_ports_ssl[0] : local.epm_foundation_ports_non_ssl[0]
      max = var.enable_ssl_ports == "True" ? local.epm_foundation_ports_ssl[0] : local.epm_foundation_ports_non_ssl[0]
    }

    protocol    = local.tcp_protocol
    source      = var.vcn_cidr
    description = "EPM Foundation Server Weblogic port"
  }
  ingress_security_rules {
    tcp_options {
      min = var.enable_ssl_ports == "True" ? local.epm_foundation_ports_ssl[1] : local.epm_foundation_ports_non_ssl[1]
      max = var.enable_ssl_ports == "True" ? local.epm_foundation_ports_ssl[1] : local.epm_foundation_ports_non_ssl[1]
    }

    protocol    = local.tcp_protocol
    source      = var.vcn_cidr
    description = "EPM Foundation Server Managed Server port"
  }
  ingress_security_rules {
    tcp_options {
      min = var.enable_ssl_ports == "True" ? local.epm_foundation_ports_ssl[2] : local.epm_foundation_ports_non_ssl[2]
      max = var.enable_ssl_ports == "True" ? local.epm_foundation_ports_ssl[2] : local.epm_foundation_ports_non_ssl[2]
    }

    protocol    = local.tcp_protocol
    source      = var.vcn_cidr
    description = "EPM Foundation Server Dimension Server port"
  }
  ingress_security_rules {
    tcp_options {
      min = var.enable_ssl_ports == "True" ? local.epm_foundation_ports_ssl[3] : local.epm_foundation_ports_non_ssl[3]
      max = var.enable_ssl_ports == "True" ? local.epm_foundation_ports_ssl[3] : local.epm_foundation_ports_non_ssl[3]
    }

    protocol    = local.tcp_protocol
    source      = var.vcn_cidr
    description = "EPM Foundation Server Dimension Server JNI Bridge port"
  }
  ingress_security_rules {
    tcp_options {
      min = var.enable_ssl_ports == "True" ? local.epm_foundation_ports_ssl[4] : local.epm_foundation_ports_non_ssl[4]
      max = var.enable_ssl_ports == "True" ? local.epm_foundation_ports_ssl[4] : local.epm_foundation_ports_non_ssl[4]
    }

    protocol    = local.tcp_protocol
    source      = var.vcn_cidr
    description = "EPM Foundation Server Reporting and Analysis Framework Agent Port"
  }
  ingress_security_rules {
    tcp_options {
      min = var.enable_ssl_ports == "True" ? local.epm_foundation_ports_ssl[5] : local.epm_foundation_ports_non_ssl[5]
      max = var.enable_ssl_ports == "True" ? local.epm_foundation_ports_ssl[5] : local.epm_foundation_ports_non_ssl[5]
    }

    protocol    = local.tcp_protocol
    source      = var.vcn_cidr
    description = "EPM Foundation Server Reporting and Analysis Framework Agent Port"
  }
  ingress_security_rules {
    tcp_options {
      min = var.enable_ssl_ports == "True" ? local.epm_planning_ports_ssl[0] : local.epm_planning_ports_non_ssl[0]
      max = var.enable_ssl_ports == "True" ? local.epm_planning_ports_ssl[0] : local.epm_planning_ports_non_ssl[0]
    }

    protocol    = local.tcp_protocol
    source      = var.vcn_cidr
    description = "EPM Planning Server Weblogic port"
  }
  ingress_security_rules {
    tcp_options {
      min = var.enable_ssl_ports == "True" ? local.epm_planning_ports_ssl[1] : local.epm_planning_ports_non_ssl[1]
      max = var.enable_ssl_ports == "True" ? local.epm_planning_ports_ssl[1] : local.epm_planning_ports_non_ssl[1]
    }

    protocol    = local.tcp_protocol
    source      = var.vcn_cidr
    description = "EPM Planning Java Web application ports"
  }
  ingress_security_rules {
    tcp_options {
      min = var.enable_ssl_ports == "True" ? local.epm_planning_ports_ssl[2] : local.epm_planning_ports_non_ssl[2]
      max = var.enable_ssl_ports == "True" ? local.epm_planning_ports_ssl[2] : local.epm_planning_ports_non_ssl[2]
    }

    protocol    = local.tcp_protocol
    source      = var.vcn_cidr
    description = "EPM Planning RMI port"
  }
  ingress_security_rules {
    tcp_options {
      min = var.enable_ssl_ports == "True" ? local.epm_essbase_ports_ssl[0] : local.epm_essbase_ports_non_ssl[0]
      max = var.enable_ssl_ports == "True" ? local.epm_essbase_ports_ssl[0] : local.epm_essbase_ports_non_ssl[0]
    }

    protocol    = local.tcp_protocol
    source      = var.vcn_cidr
    description = "EPM Essbase Server Agent port"
  }
  ingress_security_rules {
    tcp_options {
      min = var.enable_ssl_ports == "True" ? local.epm_essbase_ports_ssl[1] : local.epm_essbase_ports_non_ssl[1]
      max = var.enable_ssl_ports == "True" ? local.epm_essbase_ports_ssl[2] : local.epm_essbase_ports_non_ssl[2]
    }

    protocol    = local.tcp_protocol
    source      = var.vcn_cidr
    description = "EPM Essbase Server Agent port"
  }
  ingress_security_rules {
    tcp_options {
      min = var.enable_ssl_ports == "True" ? local.epm_essbase_ports_ssl[3] : local.epm_essbase_ports_non_ssl[3]
      max = var.enable_ssl_ports == "True" ? local.epm_essbase_ports_ssl[4] : local.epm_essbase_ports_non_ssl[4]
    }

    protocol    = local.tcp_protocol
    source      = var.vcn_cidr
    description = "EPM Essbase OPMN port"
  }
  ingress_security_rules {
    tcp_options {
      min = var.enable_ssl_ports == "True" ? local.epm_hfm_ports_ssl[0] : local.epm_hfm_ports_non_ssl[0]
      max = var.enable_ssl_ports == "True" ? local.epm_hfm_ports_ssl[0] : local.epm_hfm_ports_non_ssl[0]
    }

    protocol    = local.tcp_protocol
    source      = var.vcn_cidr
    description = "EPM Financial Management Server Weblogic port"
  }
  ingress_security_rules {
    tcp_options {
      min = var.enable_ssl_ports == "True" ? local.epm_hfm_ports_ssl[1] : local.epm_hfm_ports_non_ssl[1]
      max = var.enable_ssl_ports == "True" ? local.epm_hfm_ports_ssl[1] : local.epm_hfm_ports_non_ssl[1]
    }

    protocol    = local.tcp_protocol
    source      = var.vcn_cidr
    description = "EPM Financial Management Server Managed Server port"
  }
  ingress_security_rules {
    tcp_options {
      min = var.enable_ssl_ports == "True" ? local.epm_hfm_ports_ssl[2] : local.epm_hfm_ports_non_ssl[2]
      max = var.enable_ssl_ports == "True" ? local.epm_hfm_ports_ssl[2] : local.epm_hfm_ports_non_ssl[2]
    }

    protocol    = local.tcp_protocol
    source      = var.vcn_cidr
    description = "EPM Financial Management Server port"
  }
  ingress_security_rules {
    tcp_options {
      min = var.enable_ssl_ports == "True" ? local.epm_htp_ports_ssl[0] : local.epm_htp_ports_non_ssl[0]
      max = var.enable_ssl_ports == "True" ? local.epm_htp_ports_ssl[0] : local.epm_htp_ports_non_ssl[0]
    }

    protocol    = local.tcp_protocol
    source      = var.vcn_cidr
    description = "EPM HTP Server port"
  }
  ingress_security_rules {
    tcp_options {
      min = var.enable_ssl_ports == "True" ? local.epm_profitability_ports_ssl[0] : local.epm_profitability_ports_non_ssl[0]
      max = var.enable_ssl_ports == "True" ? local.epm_profitability_ports_ssl[0] : local.epm_profitability_ports_non_ssl[0]
    }

    protocol    = local.tcp_protocol
    source      = var.vcn_cidr
    description = "EPM Profitability Server port"
  }
  ingress_security_rules {
    tcp_options {
      min = var.enable_ssl_ports == "True" ? local.epm_fdmee_ports_ssl[0] : local.epm_fdmee_ports_non_ssl[0]
      max = var.enable_ssl_ports == "True" ? local.epm_fdmee_ports_ssl[0] : local.epm_fdmee_ports_non_ssl[0]
    }

    protocol    = local.tcp_protocol
    source      = var.vcn_cidr
    description = "EPM FDMEE Server port"
  }
  ingress_security_rules {
    tcp_options {
      min = var.enable_ssl_ports == "True" ? local.epm_strategic_finance_ports_ssl[0] : local.epm_strategic_finance_ports_non_ssl[0]
      max = var.enable_ssl_ports == "True" ? local.epm_strategic_finance_ports_ssl[0] : local.epm_strategic_finance_ports_non_ssl[0]
    }

    protocol    = local.tcp_protocol
    source      = var.vcn_cidr
    description = "EPM Strategic Finance Server port"
  }
  ingress_security_rules {
    tcp_options {
      min = local.fss_ports[0]
      max = local.fss_ports[1]
    }

    protocol = local.tcp_protocol
    source   = var.vcn_cidr
  }
  ingress_security_rules {
    tcp_options {
      min = local.fss_ports[2]
      max = local.fss_ports[2]
    }

    protocol = local.tcp_protocol
    source   = var.vcn_cidr
  }
  ingress_security_rules {
    udp_options {
      min = local.fss_ports[0]
      max = local.fss_ports[0]
    }

    protocol = local.udp_protocol
    source   = var.vcn_cidr
  }
  ingress_security_rules {
    udp_options {
      min = local.fss_ports[2]
      max = local.fss_ports[2]
    }

    protocol = local.udp_protocol
    source   = var.vcn_cidr
  }
}

# Load Balancer Security List
resource "oci_core_security_list" "WebSecList" {
  compartment_id = var.compartment_ocid
  display_name   = "WebSecList"
  vcn_id         = oci_core_virtual_network.vcn.id

  egress_security_rules {
    protocol    = local.tcp_protocol
    destination = local.anywhere
  }

  ingress_security_rules {
    tcp_options {
      min = var.epm_web_instance_listen_port
      max = var.epm_web_instance_listen_port
    }

    protocol = local.tcp_protocol
    source   = var.vcn_cidr
  }
}

# Load Balancer Security List
resource "oci_core_security_list" "LBSecList" {
  compartment_id = var.compartment_ocid
  display_name   = "LBSecList"
  vcn_id         = oci_core_virtual_network.vcn.id

  egress_security_rules {
    protocol    = local.tcp_protocol
    destination = local.anywhere
  }

  ingress_security_rules {
    tcp_options {
      min = var.load_balancer_listen_port
      max = var.load_balancer_listen_port
    }

    protocol = local.tcp_protocol
    source   = local.anywhere
  }
}



