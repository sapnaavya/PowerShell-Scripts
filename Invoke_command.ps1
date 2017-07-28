whoami

$SrvPassword = ConvertTo-SecureString "Password#123" -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential ("testadmin",$SrvPassword)
Invoke-Command -Authentication Default -ComputerName 52.175.247.14 -Credential $Credential -ScriptBlock {Get-Date}



