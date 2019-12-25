# Extract-CoveredCSS
# This script takes a Coverage file, created by Chrome-based browsers and returns the covered css in .\coverage\*-core.css and the original CSS in .\coverage\*-mantle.css
# I tried removing the covered CSS from -mantle.css, but when I merged those files I couldn't get to the original filesize, so I couldn't guarantee that way would work.
# To create the Coverage file, you can follow this tutorial: https://developers.google.com/web/tools/chrome-devtools/coverage
# Or just shortcut wizardry yourself inside Chrome:
# ctrl+shift+i
# ctrl+shift+p
# "Show Coverage"
# Click the Reload button ⟳ over on the botton "Drawer"
# Make sure to scroll around, hover on some links and menus
# Click the Export button 🡇 to download the file
# Execute this script on the Coverage file like:
# .\Extract-CoveredCSS.ps1 .\Coverage-[ISO8601 DateTime].json
# If you can't execute Extract-CoveredCSS.ps1, right click it in explorer -> Properties -> Unblock file (or something like that)

function New-Filename ($Coverage, [String]$Postfix) {
    if (("core" -ne $Postfix) -and ("mantle" -ne $Postfix)) {
        Write-Error -Message "The Postfix variable should be either 'core' or 'mantle', but it's '$Postfix'"
        return;
    }

    # I'll use the URL as a filename basis
    # Strip everything before /
    $SlashIndex = $Coverage.url.LastIndexOf("/")
    $FileName = $Coverage.url.Substring($SlashIndex + 1)

    # Strip everything after ?
    if ($FileName.IndexOf("?") -ne -1) {
        $Index = $FileName.IndexOf("?")
        $FileName = $FileName.Substring(0, $Index);
    }

    # Now, filename.ext is left, so we split that up too
    $SplitFileName = $FileName -split '\.', 2
    # and return the new filename (including the folder where the file should go)
    return ".\Coverage\$($SplitFileName[0])-$Postfix.$($SplitFileName[1])"
}
    
function Get-Extension ($Coverage) {
    # Strip everything before /
    $SlashIndex = $Coverage.url.LastIndexOf("/")
    $FileName = $Coverage.url.Substring($SlashIndex + 1)

    # Strip everything after ?
    if ($FileName.IndexOf("?") -ne -1) {
        $Index = $FileName.IndexOf("?")
        $FileName = $FileName.Substring(0, $Index);
    }

    # Now, filename.ext is left, so we split that up too
    $SplitFileName = $FileName -split '\.', 2
    # and return the new filename (including the folder where the file should go)
    return $SplitFileName[1]
}

function Write-Core ($Coverage) {
    $CoreFileName = New-Filename $Coverage 'core'
    $Ext = Get-Extension $Coverage

    # only handle CSS, not JS or anything else
    if ($Ext -like "css") {
        $Result = ""
        $Data = $Coverage.Text;

        foreach ($Range in $Coverage.Ranges) {
            $RangeDelta = $Range.end - $Range.start;
            # Here is where the extraction happens
            $Result += $Data.Substring($Range.start, $RangeDelta) + "`n";
        }
    
        Write-Output $CoreFileName
        $Result > $CoreFileName
    }
}

function Write-Mantle ($Coverage) {
    $CoreFileName = New-Filename $Coverage 'mantle'
    $Ext = Get-Extension $Coverage

    # only handle CSS, not JS or anything else
    if ($Ext -like "css") {
        $Result = ""
        $Data = $Coverage.Text;

        for ($i = 0; $i -lt $Coverage.Ranges.Length; $i++) {
            $start = $Coverage.Ranges[$i - 1].end;
            $end = $Coverage.Ranges[$i].start;
            # Special first case
            if ($i -eq 0) {
                if ($end -ne 0) {
                    $RangeDelta = $end;
                    # Here is where the extraction happens
                    $Result += $Data.Substring(0, $RangeDelta) + "`n";
                }
                continue;
            }
            $RangeDelta = $end - $start;
            if ($RangeDelta -gt 1) {
                $Result += $Data.Substring($start, $RangeDelta) + "`n";
            }
        }
    
        Write-Output $CoreFileName
        # $Result > $CoreFileName
        $Data > $CoreFileName
    }
}

$CovFilename = [String]$Args[0];
# $CovFilename = "Coverage-20191218T150005.json";

$CovFile = Get-Content -Raw $CovFilename
$Json = ConvertFrom-Json $CovFile

# create the Coverage folder where all files will go.
if (-not (Test-Path Coverage)) {
    mkdir .\Coverage
}

foreach ($Coverage in $Json) {
    Write-Core $Coverage
    Write-Mantle $Coverage
}
