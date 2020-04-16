# requires -version 7

<#

.SYNOPSIS
Encode and decode files to and from Base64

certutil.exe -encode .\message.7z out2
certutil.exe -decode .\out2 mess.7z
#>
[CmdletBinding(PositionalBinding = $True, DefaultParameterSetName = 'Groups')]
param(
    [string]$FileIn,
    [string]$FileOut,
    [switch]$Encode = $false,
    [switch]$Decode = $false,
    [switch]$Help,
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$Arguments
)

Write-Output "[INFO] Setting base options"

Set-StrictMode -Version 3.0
$ErrorActionPreference = 'Stop'
if ($Help) {
    Get-Help $PSCommandPath
    exit 1
}

Write-Output "[INFO] Checking input"

if ($FileIn -eq "") {
    Write-Output "[ERROR] I'm going to need an input file, bub!"
    Write-Output "[ERROR] Try executing:"
    Write-Output "[ERROR]   .\Encode-File.ps1 [YOUR FILE LOCATION] [OUTPUT FILE LOCATION]"
    exit 1
}

if ($FileOut -eq "") {
    Write-Output "[ERROR] I'm going to need an output file, bub!"
    Write-Output "[ERROR] Try executing:"
    Write-Output "[ERROR]   .\Encode-File.ps1 [YOUR FILE LOCATION] [OUTPUT FILE LOCATION]"
    exit 1
}

if ($Decode -eq $false -and $Encode -eq $false) {
    Write-Output "[ERROR] I'm going to need either a -Encode or -Decode flag, bub!"
}

if ($Encode -eq $true -or $Decode -eq $false) {
    Write-Output "[INFO] Encoding $FileIn"

    $Bytes = [IO.File]::ReadAllBytes($FileIn)
    $EncodedText = [Convert]::ToBase64String($Bytes)
    $EncodedText > $FileOut
}

if ($Decode -eq $true -and $Encode -eq $false) {
    Write-Output "[INFO] Decoding $FileIn"

    $File = Get-Content -Raw $FileIn
    $Bytes = [Convert]::FromBase64String($File)
    [IO.File]::WriteAllBytes($FileOut, $Bytes)
}

exit 0
