#requires -Version 7

using namespace System.Drawing

Add-Type -AssemblyName System.Drawing

$files = Get-ChildItem *.bmp
$imageFormat = "System.Drawing.Imaging.ImageFormat" -as [type]

foreach ( $file in $files) {
  $image = new-object Bitmap($file.FullName);
  $filename = $file.FullName.Split(".")[0] + ".png"
  $image.Save($filename, $imageFormat::png);
}