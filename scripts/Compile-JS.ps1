#requires -version 7

<#
.SYNOPSIS
Compile a .js file from one JavaScript version to another

.DESCRIPTION
In practice this is a simpler front-end for Google's ClosureCompiler.
This script uses ClosureCompiler to convert JavaScript from one version to another - be it ES5 to ES2019 or the other way around
(not sure why you'd want that, but ok). Newer versions of JS can be slightly smaller or faster, but no guarantees!

.PARAMETER InputFile
The original .js file: 'input.js'

.PARAMETER OutputVersion
Which version of JS the output should be (assuming the ClosureCompiler supports it)
Options are:

* ECMASCRIPT3
* ECMASCRIPT5
* ECMASCRIPT5_STRICT
* ECMASCRIPT_2015
* ECMASCRIPT_2016
* ECMASCRIPT_2017
* ECMASCRIPT_2018
* ECMASCRIPT_2019
* STABLE

.PARAMETER OutputFile
The output file: 'output.compiled.js'

.EXAMPLE
Here you explain what the execution below does
    Compile-JS.ps1 -InputFile "myJSfile.js" -OutputVersion ECMASCRIPT_2016 -OutputFile "out.js"

.EXAMPLE
The same as above, but using the short aliases
    Compile-JS.ps1 -i "myJSfile.js" -v ECMASCRIPT_2016 -o "out.js"

.EXAMPLE
If no OutputVersion is set, default to the latest version of JS (ES2019, as of writing)
    Compile-JS.ps1 -InputFile "input.js" -OutputFile "output.compiled.js"

.LINK
Online help for the ClosureCompiler: https://developers.google.com/closure/compiler/docs/gettingstarted_app
#>

[CmdletBinding(PositionalBinding = $false, DefaultParameterSetName = 'Groups')]
param(
    [Alias('i')]
    [Parameter()]
    [string]$InputFile,

    [Alias('v')]
    [ValidateSet('ECMASCRIPT3', 'ECMASCRIPT5', 'ECMASCRIPT5_STRICT', 'ECMASCRIPT_2015', 'ECMASCRIPT_2016', 'ECMASCRIPT_2017', 'ECMASCRIPT_2018', 'ECMASCRIPT_2019', 'STABLE')] # TODO: change the options for $Version
    [string]$OutputVersion = "ECMASCRIPT_2019",

    [Alias('o')]
    [string]$OutputFile,

    # Other lifecycle targets
    [Alias('h')]
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

if ("" -eq $InputFile -and "" -eq $OutputFile) {
    # using Out-Host to prevent a weird bug: https://stackoverflow.com/q/60210381/12210524
    Get-Help $PSCommandPath | Out-Host
    Get-Help $PSCommandPath -Examples | Out-Host
    exit 1
}

if ($Help) {
    Get-Help $PSCommandPath
    exit 1
}

$local:exit_code = $null
try {
    java -jar ../tools/closure-compiler-v20200204.jar --js $InputFile --language_out $OutputVersion --js_output_file $OutputFile
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
