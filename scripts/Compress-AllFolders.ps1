#requires -Version 7.0
# 7zips each folder into its own file with its own name - WON'T WORK WITH FOLDERS THAT START WITH A NUMBER!!!
# source: https://community.spiceworks.com/topic/780460-zip-folders-via-powershell
if (-not (test-path "$env:ProgramFiles\7-Zip\7z.exe")) { throw "$env:ProgramFiles\7-Zip\7z.exe needed" } 
# variables can't start with a number :(
set-alias SevenZip "$env:ProgramFiles\7-Zip\7z.exe"
$directories = Get-ChildItem -Directory

# Creates 7z files based on the parent folders name and drops it inside the archive folder
ForEach ($dir in $directories) {
    $dirname = $dir.name
    $zipname = $name
    # archive with type of 7z, with compression level 3 (fast)
    SevenZip a -t7z -mx3 "$zipname" "$dirname"
}
