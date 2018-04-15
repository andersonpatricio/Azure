param (
	[Parameter(Mandatory=$True)]
    	[string]$pKeyVault,
	[string]$pApp
)

$vKeyVault = Get-AzureRMKeyVault $pKeyVault
If ($vKeyVault -eq $null) {Write-Host "Key Vault wasn't found"; exit}
Write-Host "The current Key Vault has this/these following key(s) - KeyEncryptionKeyUrl:"
Write-Host
Get-AzureKeyVaultKey -VaultName $vKeyVault.VaultName | foreach { (Get-AzureKeyVaultKey -VaultName $vKeyVault.VaultName -Name $_.Name).key.kid }

If ($pApp -ne $null) {
	write-host
	write-host "==Application/SP Info======"
	write-host
	$vApp = Get-AzureRMADApplication -DisplayNameStartWith $pApp
	If ($vApp -ne $null) {
		Write-Host "Display Name.....: " $VApp.DisplayName
		Write-Host "AADClientID......: " $vApp.ApplicationID
		} Else {Write-Host "Sorry, Application cannot be found."; exit}	
	}

Write-Host
Write-Host "==PowerShell Info======="
Write-Host "AADClientID.....................: " $vApp.ApplicationID
Write-Host "DiskEncryptionKeyVaultUrl.......: " $vKeyVault.VaultURI
Write-Host "DiskEncryptionKeyVaultId........: " $keyVault.ResourceId
Write-Host "KeyEncryptionKeyUrl (BitLocker).: "  (Get-AzureKeyVaultKey -VaultName $keyVaultName -Name BitLocker).Key.kid
Write-Host "KeyEncryptionKeyVaultId.......... "  $keyVault.ResourceId


Write-Host "You are ready to start the encryption process on your existent VMs!"