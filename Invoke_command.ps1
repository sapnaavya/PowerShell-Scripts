#Login-AzureRmAccount
$Credential = Get-Credential
Invoke-Command -ComputerName 52.175.247.14 -Credential $Credential -ScriptBlock {Get-Content -Path C:\Users\Public\Documents\date.txt|Out-File anothercomp.txt }
#$session = New-PSSession -ComputerName 52.175.247.14 -Credential $Credential
#Enter-PSSession -Session $session
#Remove-PSSession $session 