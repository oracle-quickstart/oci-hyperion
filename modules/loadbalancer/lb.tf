/*Copyright © 2020, Oracle and/or its affiliates.

The Universal Permissive License (UPL), Version 1.0*/

resource "oci_load_balancer_load_balancer" "lb" {
  shape          = var.load_balancer_shape
  compartment_id = var.compartment_ocid
  subnet_ids     = [var.load_balancer_subnet]
  display_name   = var.load_balancer_name
  is_private     = var.load_balancer_private
  freeform_tags  = var.freeform_tags
}

resource "oci_load_balancer_backend_set" "lb-bset" {
  depends_on       = [oci_load_balancer_load_balancer.lb]
  name             = "${var.load_balancer_name}-bes"
  load_balancer_id = oci_load_balancer_load_balancer.lb.id
  policy           = "ROUND_ROBIN"

  health_checker {
    port                = var.web_instance_listen_port
    protocol            = "HTTP"
    response_body_regex = ".*"
    url_path            = "/"
  }
  session_persistence_configuration {
    cookie_name      = "lb-sessprs"
    disable_fallback = true
  }

}

resource "oci_load_balancer_backend" "lb-bset-be" {
  depends_on = [
    oci_load_balancer_load_balancer.lb,
    oci_load_balancer_backend_set.lb-bset,
  ]
  count            = var.web_instance_count
  load_balancer_id = oci_load_balancer_load_balancer.lb.id
  backendset_name  = oci_load_balancer_backend_set.lb-bset.name
  ip_address       = element(var.be_ip_addresses, count.index)
  port             = var.web_instance_listen_port
  backup           = false
  drain            = false
  offline          = false
  weight           = 1



}

resource "oci_load_balancer_hostname" "hostname" {
  #  count            = length(var.availability_domain)
  hostname         = var.load_balancer_hostname
  load_balancer_id = oci_load_balancer_load_balancer.lb.id
  name             = "epm-hostname"
}

resource "oci_load_balancer_listener" "lb-listener" {
  depends_on = [
    oci_load_balancer_load_balancer.lb,
    oci_load_balancer_backend_set.lb-bset,
    oci_load_balancer_hostname.hostname,
  ]
  load_balancer_id         = oci_load_balancer_load_balancer.lb.id
  name                     = "${var.load_balancer_name}-lsnr"
  default_backend_set_name = oci_load_balancer_backend_set.lb-bset.name
  hostname_names           = [oci_load_balancer_hostname.hostname.name]
  port                     = var.load_balancer_listen_port
  protocol                 = "HTTP"
  connection_configuration {
    idle_timeout_in_seconds = "2"
  }
}

output "LoadbalancerIP" {
  description = "Load balancer IP"
  value       = oci_load_balancer_load_balancer.lb.ip_addresses
}