$Credential = Get-Credential
Invoke-Command -ComputerName 52.175.247.14 -Credential $Credential -ScriptBlock {Get-Date}


