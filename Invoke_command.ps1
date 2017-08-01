whoami

$SrvPassword = ConvertTo-SecureString "Password#123" -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential ("testadmin",$SrvPassword)
Invoke-Command -Authentication Default -ComputerName 52.183.60.0 -Credential $Credential -ScriptBlock {Get-Date}



