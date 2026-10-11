Add-Type -AssemblyName System.Drawing

function Crop-Image($sourcePath, $destPath, $x, $y, $width, $height) {
    $src = [System.Drawing.Image]::FromFile($sourcePath)
    $rect = New-Object System.Drawing.Rectangle($x, $y, $width, $height)
    $bmp = New-Object System.Drawing.Bitmap($width, $height)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.DrawImage($src, (New-Object System.Drawing.Rectangle(0, 0, $width, $height)), $rect, [System.Drawing.GraphicsUnit]::Pixel)
    $bmp.Save($destPath, [System.Drawing.Imaging.ImageFormat]::Jpeg)
    $g.Dispose()
    $bmp.Dispose()
    $src.Dispose()
    Write-Host "Cropped $destPath"
}

Crop-Image 'c:\Users\ATC\Desktop\welty\assets\images\backgrounds\hero_mockup.jpg' 'c:\Users\ATC\Desktop\welty\assets\images\products\molded_luxury.jpg' 770 190 200 215
Crop-Image 'c:\Users\ATC\Desktop\welty\assets\images\backgrounds\hero_mockup.jpg' 'c:\Users\ATC\Desktop\welty\assets\images\products\card_bars.jpg' 42 410 165 125
Crop-Image 'c:\Users\ATC\Desktop\welty\assets\images\backgrounds\hero_mockup.jpg' 'c:\Users\ATC\Desktop\welty\assets\images\products\card_molded.jpg' 355 410 165 125
Crop-Image 'c:\Users\ATC\Desktop\welty\assets\images\backgrounds\hero_mockup.jpg' 'c:\Users\ATC\Desktop\welty\assets\images\products\card_wholesale.jpg' 665 410 165 125
