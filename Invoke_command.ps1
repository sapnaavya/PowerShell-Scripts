﻿##Login-AzureRmAccount
##$Credential = Get-Credential
################################################
$SrvPassword = ConvertTo-SecureString "$($ENV:Password)" -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential ("$ENV:UserName", $SrvPassword)
Invoke-Command -ComputerName 52.175.247.14 -Credential $Credential -ScriptBlock {Get-Date}
###############################################
#$session = New-PSSession -ComputerName 52.175.247.14 -Credential $Credential
#Enter-PSSession -Session $session
#Remove-PSSession $session 



