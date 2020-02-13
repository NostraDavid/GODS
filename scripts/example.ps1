#requires -version 7

<#

.SYNOPSIS
A oneliner of explanation

.DESCRIPTION
A multiline
description
of the project

.PARAMETER One
The first operator
This text is the explanation of the parameter
As you can see, it can be multiline

.PARAMETER Two
The second parameter

.PARAMETER Three
The third parameter

.PARAMETER Four
The fourth parameter

.EXAMPLE
Here you explain what the execution below does

    example.ps1 -One -Two -Three "string"

.EXAMPLE
Another example, this time without One and Two

    example.ps1 -Three "string" -Fourth "OptionOne"

.EXAMPLE
Another example, this time without One and Two

    example.ps1 -Three "string" -f "OptionTwo"

.EXAMPLE
To see example executions

    Get-Help .\example.ps1 -Examples

.LINK
Clickable links that you want to add: https://github.com/dotnet/aspnetcore/blob/master/docs/BuildFromSource.md

#>

[CmdletBinding(PositionalBinding = $false, DefaultParameterSetName = 'Groups')]
param(
    [switch]$One,
    [switch]$Two,
    [string]$Three,

    [Alias('f')]
    [ValidateSet('OptionOne', 'OptionTwo')]
    $Fourth = 'OptionOne', # OptionOne is the default

    # Other lifecycle targets
    [switch]$Help, # Show help

    # Capture the rest
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$Arguments
)

# -Version 3.0 is currently the highest version:
# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/set-strictmode?view=powershell-7#parameters
Set-StrictMode -Version 3.0

# ErrorActionPreference options are:
# SilentlyContinue  — Don't display an error message continue to execute subsequent commands.
# Continue          — Display any error message and attempt to continue execution of subsequence commands.
# Inquire           — Prompts the user whether to continue or terminate the action
# Stop              — Terminate the action with error.
$ErrorActionPreference = 'Stop'

if ($Help) {
    Get-Help $PSCommandPath
    exit 1
}

if (-not $Fourth) {
    $Fourth = if ($CI) { 'OptionOne' } else { 'OptionTwo' }
}
$Arguments += "$Fourth"


$local:exit_code = $null
try {
    # code
}
catch {
    Write-Host $_.ScriptStackTrace
    $exit_code = 1
}
finally {
    if (! $exit_code) {
        $exit_code = $LASTEXITCODE
    }

    # cleanup or something
}

exit $exit_code
