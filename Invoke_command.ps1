$SrvPassword = ConvertTo-SecureString $ENV:Password -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential ($ENV:UserName,$SrvPassword)
Invoke-Command -Authentication Default -ComputerName 52.175.247.14 -Credential $Credential -ScriptBlock {Get-Date}


