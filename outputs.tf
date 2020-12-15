/*Copyright © 2020, Oracle and/or its affiliates.

The Universal Permissive License (UPL), Version 1.0*/

output "bastion_public_ips" {
  value = [module.create_bastion.Bastion_Public_IPs]
}

output "epm_foundation_server_private_ips" {
  value = formatlist(
    "%s:%s:%s:   %s    ",
    module.create_foundation.ComputePrivateIPs,
    module.create_foundation.ComputeWinHostNames,
    module.create_foundation.ComputeWinusers,
    module.create_foundation.ComputeWincreds,
  )
}

output "epm_hfm_server_private_ips" {
  value = formatlist(
    "%s:%s:%s:   %s    ",
    module.create_hfm.ComputePrivateIPs,
    module.create_hfm.ComputeWinHostNames,
    module.create_hfm.ComputeWinusers,
    module.create_hfm.ComputeWincreds,
  )
}

output "epm_web_server_private_ips" {
  value = formatlist(
    "%s:%s:%s:   %s    ",
    module.create_web.ComputePrivateIPs,
    module.create_web.ComputeWinHostNames,
    module.create_web.ComputeWinusers,
    module.create_web.ComputeWincreds,
  )
}

output "epm_planning_server_private_ips" {
  value = formatlist(
    "%s:%s:%s:   %s    ",
    module.create_planning.ComputePrivateIPs,
    module.create_planning.ComputeWinHostNames,
    module.create_planning.ComputeWinusers,
    module.create_planning.ComputeWincreds,
  )
}

output "epm_essbase_server_details" {
  value = formatlist(
    "%s:%s:%s:   %s    ",
    module.create_essbase.ComputePrivateIPs,
    module.create_essbase.ComputeWinHostNames,
    module.create_essbase.ComputeWinusers,
    module.create_essbase.ComputeWincreds,
  )
}

output "epm_profitability_server_details" {
  value = formatlist(
    "%s:%s:%s:   %s    ",
    module.create_profitability.ComputePrivateIPs,
    module.create_profitability.ComputeWinHostNames,
    module.create_profitability.ComputeWinusers,
    module.create_profitability.ComputeWincreds,
  )
}

output "epm_strategic_finance_server_details" {
  value = formatlist(
    "%s:%s:%s:   %s    ",
    module.create_strategic_finance.ComputePrivateIPs,
    module.create_strategic_finance.ComputeWinHostNames,
    module.create_strategic_finance.ComputeWinusers,
    module.create_strategic_finance.ComputeWincreds,
  )
}

output "load_balancer_ip" {
  value       = module.create_lb.LoadbalancerIP
  description = "IP of Load Balancer"
}

output "database_connection_string" {
  value       = module.create_db.dbcon
  description = "Database Connection String"
}