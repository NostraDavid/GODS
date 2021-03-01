# Check PowerShell is running as Administrator
$Principal = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent())

If (-Not ($Principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))) {
    Write-Warning "You do not have Administrator rights to run this script.  Please run PowerShell as an Administrator."
    Break
}


# Inbound Rule
$SearchIn = @{
    "DisplayName" = "Windows Search (MyRule-In)"
    "Package"     = "S-1-15-2-536077884-713174666-1066051701-3219990555-339840825-1966734348-1611281757"
    "Enabled"     = "True"
    "Action"      = "Block"
    "Direction"   = "Inbound"
}

If (-Not (Get-NetFirewallRule -DisplayName $SearchIn.DisplayName -ErrorAction SilentlyContinue) ) {
    New-NetFirewallRule @SearchIn
}

Else {
    Set-NetFirewallRule @SearchIn
}

# Outbound Rule
$SearchOut = @{
    "DisplayName" = "Windows Search (MyRule-Out)"
    "Package"     = "S-1-15-2-536077884-713174666-1066051701-3219990555-339840825-1966734348-1611281757"
    "Enabled"     = "True"
    "Action"      = "Block"
    "Direction"   = "Outbound"
}

If (-Not (Get-NetFirewallRule -DisplayName $SearchOut.DisplayName -ErrorAction SilentlyContinue) ) {
    New-NetFirewallRule @SearchOut
}

Else {
    Set-NetFirewallRule @SearchOut
}