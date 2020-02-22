# Use this on C:\ to remove ALL empty files from the drive.
Get-ChildItem -Recurse | Where-Object {$_.Length -eq 0}