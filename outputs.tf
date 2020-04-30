/*Copyright © 2020, Oracle and/or its affiliates.

The Universal Permissive License (UPL), Version 1.0*/

output "BastionPublicIPs" {
    value = ["${module.create_bastion.Bastion_Public_IPs}"]
}
output "epmFoundationServerPrivateIPs" {
    value = "${formatlist("%s:%s:%s:   %s    ", module.create_foundation.ComputePrivateIPs, module.create_foundation.ComputeWinHostNames, module.create_foundation.ComputeWinusers, module.create_foundation.ComputeWincreds)}"
}

output "epmHFMServerPrivateIPs" {
    value = "${formatlist("%s:%s:%s:   %s    ", module.create_hfm.ComputePrivateIPs, module.create_hfm.ComputeWinHostNames, module.create_hfm.ComputeWinusers, module.create_hfm.ComputeWincreds)}"
}

output "epmWebServerPrivateIPs" {
    value = "${formatlist("%s:%s:%s:   %s    ", module.create_web.ComputePrivateIPs, module.create_web.ComputeWinHostNames, module.create_web.ComputeWinusers, module.create_web.ComputeWincreds)}"
}

output "epmPlanningServerPrivateIPs" {
    value = "${formatlist("%s:%s:%s:   %s    ", module.create_planning.ComputePrivateIPs, module.create_planning.ComputeWinHostNames, module.create_planning.ComputeWinusers, module.create_planning.ComputeWincreds)}"
}

output "epmEssbaseServerDetails" {
  value = "${formatlist("%s:%s:%s:   %s    ", module.create_essbase.ComputePrivateIPs, module.create_essbase.ComputeWinHostNames, module.create_essbase.ComputeWinusers, module.create_essbase.ComputeWincreds)}"
}

output "epmProfitabilityServerDetails" {
  value = "${formatlist("%s:%s:%s:   %s    ", module.create_profitability.ComputePrivateIPs, module.create_profitability.ComputeWinHostNames, module.create_profitability.ComputeWinusers, module.create_profitability.ComputeWincreds)}"
}

output "epmStrategicFinanceServerDetails" {
  value = "${formatlist("%s:%s:%s:   %s    ", module.create_strategic_finance.ComputePrivateIPs, module.create_strategic_finance.ComputeWinHostNames, module.create_strategic_finance.ComputeWinusers, module.create_strategic_finance.ComputeWincreds)}"
}

