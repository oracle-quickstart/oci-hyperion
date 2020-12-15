#ps1_sysnative

# Hyperion prerequisites

Write-Output "Disabling UAC"
cmd /C 'reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f'
Write-Output "UAC Disabled..."

Write-Output "Disabling Data Execution Prevention (DEP)"
cmd /C 'bcdedit /set nx AlwaysOff'
Write-Output "DEP Disabled..."

Write-Output "Updating Advanced Settings / Adjust for Best Performance (UI)"
cmd /C 'reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f'
Write-Output "Adjusted for Best Performance..."

# Configure and Mount FSS
Write-Output "Configuring FSS"
Start-Process powershell -Verb runAs
Install-WindowsFeature -Name NFS-Client

Set-ItemProperty HKLM:\SOFTWARE\Microsoft\ClientForNFS\CurrentVersion\Default -Name AnonymousUid -Value 0
Set-ItemProperty HKLM:\SOFTWARE\Microsoft\ClientForNFS\CurrentVersion\Default -Name AnonymousGid -Value 0

Stop-Service -Name NfsClnt
Restart-Service -Name NfsRdr
Start-Service -Name NfsClnt
Write-Output "FSS configuration Complete"

Write-Output "Mount FSS"
cmd /C 'mount ${fss_mount_target_private_ip}:${fss_export_path} ${fss_mount_path}'
Write-Output "FSS mount complete..."