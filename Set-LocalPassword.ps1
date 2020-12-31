#Requires -Version 5.1
$Users = @()
$ExistingUsers = @((Get-LocalUser | Select-Object Name).Name)
$key = (1)
$SecureString = Get-Content "<MyPasswordFile>"
$password = ConvertTo-SecureString $SecureString -Key $key

Try {
    ForEach ($U in $Users) {
        ForEach ($E in $ExistingUsers) {
            if ($U -eq $E) {
                Set-LocalUser -Name $U -Password $password
                Write-Host "Success:`n`tUser - $($U)`n`tPassword has been changed.`n" -ForegroundColor Cyan
            }
        }
    }
}
Catch {
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red -BackgroundColor Black
}
