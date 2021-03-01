#requires -version 5.1

<#

.SYNOPSIS
Remove all comments for a Reddit user (to which you have access) where karma is below a certain value (default is 10).

.DESCRIPTION
Install PSRAW (you don't even need an admin shell):

  Install-Module -Name PSRAW -Scope CurrentUser

To see if it's installed:

  Get-Module PSRAW -ListAvailable

To uninstall (after you're done with this script):

  Uninstall-Module PSRAW

How to gain access to Reddit's API:

1. Go to https://www.reddit.com/prefs/apps
2. Click "create another app..."
3. Fill in a name (anything goes as we won't use it for this script)
4. Select "Script"
5. Put "http://localhost:8080" in 'Redirect Uri'
6. Click "create app"

See the Examples below on how to run this script

.PARAMETER ClientId
The weird string below "personal use script" on the /prefs/app page of reddit.

It looks something like "8u_z0wNkkRoILQ", "u_yeba_0VSWNaA" or "vb_SoElZSTiYZw"

.PARAMETER ClientSecret
The "secret" value on the /prefs/app page of reddit.

It looks something like "iaAS_xZb8L2K1x_xCHreDGVbxZd" or "gH9_pO-Bcjr3lejZCaTkw8sw7vk"

.PARAMETER Username
Your reddit username, for the account that has created the ClientId and ClientSecret thingy above

.PARAMETER Password
Your reddit password, for the account that has created the ClientId and ClientSecret thingy above

NOTE: IF YOUR PASSWORD CONTAINS ANY OF THE FOLLOWING 3 CHARACTERS, PLEASE CHANGE YOUR PASSWORD IF YOU'RE GETTING A 401 UNAUTHORIZED:

   `$

Maybe it won't matter, but those characters mean something special to PowerShell

.PARAMETER RedirectUri
Though you can technically pick whatever you want, I'm going to presume it's "https://localhost:8080/"

This parameter is optional and its default value is "https://localhost:8080/"

.PARAMETER Threshold
The minimum needed karma to NOT be deleted. In other words: Every comment, which karma is below this threshold, will be deleted.

This parameter is optional and its default value is 10 (so all comments that have a karma of 9 and lower will be deleted)

.EXAMPLE
Running the script with minimal information

    Remove-LowKarmaComments.ps1 -ClientID u_yeba_0VSWNaA -ClientSecret iaAS_xZb8L2K1x_xCHreDGVbxZd -Username spez -Password spez

.EXAMPLE
Running the script with all information

    Remove-LowKarmaComments.ps1 -ClientID vb_SoElZSTiYZw -ClientSecret gH9_pO-Bcjr3lejZCaTkw8sw7vk -Username kn0thing -Password "My wife has a ph4t ass!" -RedirectUri "https://www.example.com:42069/myscript" -Threshold 69 -UserAgent "Reddit sucks - lmaooooo"

.LINK
https://github.com/NostraDavid/GODS

#>

[CmdletBinding(PositionalBinding = $false, DefaultParameterSetName = 'Groups')]
param(
    [string]$ClientId,
    [String]$ClientSecret,
    [string]$Username,
    [String]$Password,
    [string]$RedirectUri = "http://localhost:8080",
    [int]$Threshold = 10,

    [switch]$Help,

    # Capture the rest
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$Arguments
)

# Normally I'd use Set-StrictMode, but that breaks PSRAW, so no usage this one time.
# Set-StrictMode -Version 3.0

# See example.ps1
$ErrorActionPreference = 'Stop'

if ($ClientId -eq "" -or $Username -eq "") {
    Get-Help $PSCommandPath -Detailed | more
    exit 1
}

if ($Help) {
    Get-Help $PSCommandPath
    exit 1
}

Import-Module PSRAW

# I tried to accept an already-converted SecureString, but that would just fuck with the user experience, IMO.
$ClientSecret = ConvertTo-SecureString -String $ClientSecret -AsPlainText -Force
$Password = ConvertTo-SecureString -String $Password -AsPlainText -Force

$Params = @{
    Script           = $True
    Description      = ""
    RedirectUri      = $RedirectUri
    UserAgent        = "PowerShell:PSRAW:2.0 (by /u/markekraus)"
    GUID             = [guid]::NewGuid()
    ClientCredential = $ClientCredential
    UserCredential   = $UserCredential
}

$RedditApp = New-RedditApplication @Params

try {
    # $RedditApp | Request-RedditOAuthToken -Script
    # $token = Request-RedditOAuthToken -Script -Application $RedditApp 
    Request-RedditOAuthToken -Script -Application $RedditApp 
}
catch {
    Write-Warning "Could not connect to Reddit"
    Write-Warning "[ERROR] Full message: $($Error[0])"
    exit
}

try {
    $Messages = @()
    $Count = 0
    $After = ""

    while ($Messages[-1] -ne $After ) {
        # $Uri = "https://oauth.reddit.com/user/$Username/comments?limit=100"
        $Uri = "https://oauth.reddit.com/user/$Username/comments?count=$Count&after=$After&limit=100"
        $Response = Invoke-RedditRequest -Uri $Uri
        $temp = $Response.ContentObject.data.children.data
        $Messages += $temp
        $After = $Messages[-1].name
    }

    $negatives = $Messages.Where({$_.score -lt $Threshold})
    $Uri = "https://oauth.reddit.com/api/del"
    # $Uri = "https://oauth.reddit.com/user/$Username/comments?count=25&after=t1_fqi3ck&limit=1000"
    
    # $Uri = "https://oauth.reddit.com/message/inbox"
    # $Response = Invoke-RedditRequest -Uri $Uri
    # $Messages = $Response.ContentObject.data.children.data
    # Write-Output $Messages.Where( { $_.score -lt $Threshold } )
    # Write-Output $Messages.Count

    # foreach ($Message in $Messages) {
    #     if ($Message.score -lt 5) {
    #         Write-Output $Messages
    #     }
    # }
}
catch [InvalidOperation] {
    Write-Warning "Something went wrong when requesting the messages"
    Write-Warning "[ERROR] Full message: $($Error[0])"
    exit 3
}