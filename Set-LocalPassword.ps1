<#
    .Synopsis
        Will use templates to create new checklists for all machines specified
    .NOTES
        Created by: Robert Owens
        Date: December 31, 2020
    .PARAMETER Destination
        Destination where the results will go       
    .EXAMPLE
        .\Copy-Checklist -Destination "C:\ProgramData\ChecklistResults"
#>

#Requires -Version 5.1
param (
    [Parameter (
        Mandatory = $True
        )]
    [string[]]$Users,
    [Parameter (
        Mandatory = $True
        )]
    [string]$Password = Read-Host "Password: " -AsSecureString
    )
    
$ExistingUsers = @((Get-LocalUser | Select-Object Name).Name)
$key = (1)
$password = ConvertTo-SecureString $SecureString -Key $key

Try {
    ForEach ($U in $Users) {
        ForEach ($E in $ExistingUsers) {
            if ($U -eq $E) {
                Set-LocalUser -Name $U -Password $Password
                Write-Host "Success:`n`tUser - $($U)`n`tPassword has been changed.`n" -ForegroundColor Cyan
            }
        }
    }
}
Catch {
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red -BackgroundColor Black
}
