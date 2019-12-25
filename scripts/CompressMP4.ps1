Function Get-Metadata {
    [cmdletbinding()]
    Param(
        [Parameter(
            Mandatory = $true,
            Position = 0,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true)]
        [array]$File
    )
    $object = New-Object -ComObject Shell.Application
    $space = $object.namespace($(Split-Path $File))
    $fileitem = $space.ParseName($(Split-Path $File -Leaf))

    $MetaData = New-Object -TypeName PSObject

    For ($a = 0; $a -le 266; $a++) {
        $key = $($space.GetDetailsOf($space.Items, $a))
        if ($key -eq "Length") {
            $value = $($space.GetDetailsOf($fileitem, $a)) 
            $hash += @{$key = $value }
            Try {
                $MetaData | Add-Member $hash -ErrorAction SilentlyContinue
            }
            Catch {
            }
            $hash.Clear()
        }
    }

    return $MetaData
}

Write-Output "This script requires an Nvidia card of the 1000 series or newer because it uses the hevc_nvenc encoder, which is basically Nvidia only."
Write-Output "If you don't have that, change -c:v from hevc_nvenc (see 'data\CompressMP4 Scripts.txt' for options)"
Write-Output "Original script from https://github.com/EposVox/WindowsMods, but I hate batch files"
# Settings constants
Set-Variable tempThumbnail -option Constant -value "temp_thumbnail_sWOq5gKeIy.jpg"
Set-Variable tempFile -option Constant -value "temp_videofile_W38yQ57LdN.mp4"

foreach ($oldFile in $(Get-ChildItem *.mp4, *.3gp, *.avi)) {
    # Only process unprocessed files
    if ($oldFile.BaseName -notmatch "_CRF24_HEVC") {
        Write-Output "Processing $($oldFile.Name)"
        $newFileName = "$($oldFile.BaseName)_CRF24_HEVC.mp4"
        Write-Output "Converting video"
        ./../tools/ffmpeg -strict 2 -hwaccel auto -i $oldFile.Name -c:v hevc_nvenc -rc constqp -qp 25 -b:v 0K -c:a aac -map 0 $newFileName

        $newFile = Get-ChildItem "$($oldFile.BaseName)_CRF24_HEVC.mp4"

        # Overwrite the file, if newfile size is smaller (Lesser Than) oldfile
        if ($newFile.Length -lt $oldFile.Length) {
            Write-Output "Extracting thumbnail"

            if ((Get-Metadata $oldFile.FullName).Length -gt 3) {
                # normally get a frame on the 3rd second
                ./../tools/ffmpeg -i $oldFile.Name -vframes 1 -ss 3 $tempThumbnail -y
            }
            else {
                # if the video is too short, just get the first frame
                ./../tools/ffmpeg -i $oldFile.Name -vframes 1 -ss 0 $tempThumbnail -y
            }

            Write-Output "Inserting thumbnail"
            ./../tools/ffmpeg -i $newFile.Name -i $tempThumbnail -map 1 -map 0 -c copy -disposition:0 attached_pic $tempFile -y
            Remove-Item $tempThumbnail
            
            # Since ffmpeg can't write over a file it's reading over, I'm using $tempFile as temporary storage
            $tempname = $newFile.Name
            Remove-Item $newFile
            Move-Item $tempFile $tempname
            
            Write-Output "Copying attributes"
            $newFile.creationtime = $oldFile.creationtime
            $newFile.lastaccesstime = $oldFile.lastaccesstime
            $newFile.lastwritetime = $oldFile.lastwritetime

            Write-Output "Overwriting original file"
            $tempname = $oldFile.BaseName
            Remove-Item $oldFile
            Move-Item $newFile "$($tempname).mp4"
        } else {
            Remove-Item $newFile
        }

        Write-Output "Processed $($oldFile.Name)"
    }
}
