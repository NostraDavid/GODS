Write-Output "Installing Chocolatey"
Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

Write-Output "Installing best font (including PowerLine versions)"
choco install cascadiafonts

Write-Output "Installing best editor"
choco install vscode

