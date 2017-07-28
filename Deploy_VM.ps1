#region 
#Logs into azure and gets subscription
Login-AzureRmAccount
$azureSubscription = Get-AzureRmSubscription
Select-AzureRmSubscription -SubscriptionId $azureSubscription.SubscriptionId -TenantId $azureSubscription.TenantId
#endregion

$rgName = "JenkinGrp"
$location = "west us 2"
$storageAccountName = "sqlteststoragesap"
$vmName = "JenkinsVM"
$VMSize = "Standard_A2"
$nicName = "$vmName-NIC"
$ipName = "$vmName-IP" 
$nsgName = "$vmName-NSG"
$ruleName = "$vmName-Rule"
$subnetName = "$vmName-Subnet"
$vnetName = "$vmName-V-Net"
$family="SQL Server 2016 SP1 Enterprise on Windows Server 2016"
$PublisherName = "MicrosoftSQLServer"
$OfferName = "SQL2016SP1-WS2016"
$Sku = "Enterprise"
$Version = "latest"
$OSDiskName = $vmName + "OSDisk"

#storage
New-AzureRmResourceGroup -Name $rgName -Location $location
New-AzureRmStorageAccount -ResourceGroupName $rgName -Name $storageAccountName -Location $location -SkuName "Standard_LRS" -Kind "Storage"

#network
$singleSubnet = New-AzureRmVirtualNetworkSubnetConfig -Name $subnetName -AddressPrefix 10.0.0.0/24
$vnet = New-AzureRmVirtualNetwork -Name $vnetName -ResourceGroupName $rgName -Location $location -AddressPrefix 10.0.0.0/16 -Subnet $singleSubnet
$pip = New-AzureRmPublicIpAddress -Name $ipName -ResourceGroupName $rgName -Location $location -AllocationMethod Dynamic | Out-Null
$pip = Get-AzureRmPublicIpAddress -ResourceGroupName $rgName -Name $ipName
$nic = New-AzureRmNetworkInterface -Name $nicName -ResourceGroupName $rgName -Location $location -SubnetId $vnet.Subnets[0].Id -PublicIpAddressId $pip.Id | Out-Null
$nic = Get-AzureRmNetworkInterface -ResourceGroupName $rgName -Name $nicName
Select-AzureRmSubscription -SubscriptionId $azureSubscription.SubscriptionId -TenantId $azureSubscription.TenantId
# Compute
$vm = New-AzureRmVMConfig -VMName $VMName -VMSize $VMSize
$Credential = Get-Credential -Message "Type the name and password of the local administrator account."
$vm = Set-AzureRmVMOperatingSystem -VM $vm -Windows -ComputerName $vmName -Credential $Credential -ProvisionVMAgent -EnableAutoUpdate #-TimeZone = $TimeZone
$vm = Add-AzureRmVMNetworkInterface -VM $vm -Id $nic.Id
$azureStorageAcc = Get-AzureRmStorageAccount | Where-Object StorageAccountName -EQ $storageAccountName
$OSDiskUri = $azureStorageAcc.PrimaryEndpoints.Blob.ToString() + "vhds/" + $OSDiskName + ".vhd"
$vm = Set-AzureRmVMOSDisk -VM $vm -Name $OSDiskName -VhdUri $OSDiskUri -Caching ReadOnly -CreateOption FromImage
$vm = Set-AzureRmVMSourceImage -VM $vm -PublisherName $PublisherName -Offer $OfferName -Skus $Sku -Version $Version

## Create the VM in Azure
New-AzureRmVM -ResourceGroupName $rgName -Location $location -VM $vm
