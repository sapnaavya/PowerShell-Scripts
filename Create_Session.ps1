whoami
$SrvPassword = ConvertTo-SecureString "Password#123" -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential ("testadmin",$SrvPassword)
$session = New-PSSession -ComputerName 52.183.60.0 -Credential $Credential
Enter-PSSession -Session $session
(Get-ChildItem).Name
