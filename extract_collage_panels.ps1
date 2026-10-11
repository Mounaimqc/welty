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
    Write-Host "Saved $destPath ($width x $height)"
}

$collage = 'C:\Users\ATC\.gemini\antigravity-ide\brain\a4d83515-568a-4629-917d-fcb2195adf30\.user_uploaded\media_1791710712844.jpg'

Copy-Item $collage 'c:\Users\ATC\Desktop\welty\assets\images\products\welty_master_collage.jpg' -Force
Copy-Item $collage 'c:\Users\ATC\Desktop\welty\assets\images\brand\welty_collage.jpg' -Force

# Panel 1: Top-Left (Boxes Display) - x: 0 to 341, y: 0 to 341
Crop-Image $collage 'c:\Users\ATC\Desktop\welty\assets\images\products\bars_boxes_display.jpg' 0 0 341 341

# Panel 2: Top-Center (Bars Trio) - x: 341 to 682, y: 0 to 341
Crop-Image $collage 'c:\Users\ATC\Desktop\welty\assets\images\products\bars_trio_v2.jpg' 341 0 341 341

# Panel 3: Top-Right (Green Box Display) - x: 682 to 1024, y: 0 to 341
Crop-Image $collage 'c:\Users\ATC\Desktop\welty\assets\images\products\bars_box_green.jpg' 682 0 342 341

# Panel 4: Bottom-Left (Molded Box 80 pcs) - x: 0 to 341, y: 341 to 682
Crop-Image $collage 'c:\Users\ATC\Desktop\welty\assets\images\products\molded_box_80.jpg' 0 341 341 341

# Panel 5: Bottom-Center (Molded Close-up) - x: 341 to 682, y: 341 to 682
Crop-Image $collage 'c:\Users\ATC\Desktop\welty\assets\images\products\molded_closeup.jpg' 341 341 341 341

# Panel 6: Bottom-Right (Wholesale Master Carton + Boxes) - x: 682 to 1024, y: 341 to 682
Crop-Image $collage 'c:\Users\ATC\Desktop\welty\assets\images\products\wholesale_carton_v2.jpg' 682 341 342 341
