#requires -Version 7

using namespace System.Drawing

Add-Type -AssemblyName System.Drawing

$files = Get-ChildItem *.png
$imageFormat = "System.Drawing.Imaging.ImageFormat" -as [type]

foreach ( $file in $files) {
  $image = new-object Bitmap($file.FullName);
  $filename = $file.FullName.Split(".")[0] + ".bmp"
  $image.Save($filename, $imageFormat::bmp);
}