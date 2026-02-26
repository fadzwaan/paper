# Load the required .NET assembly for working with images
Add-Type -AssemblyName System.Drawing

# Define the Rotate-Image function
function Rotate-Image {
    param(
        [Parameter(Mandatory = $true)]
        [string]$InputPath,

        [Parameter(Mandatory = $true)]
        [string]$OutputPath,

        [ValidateSet(90, 180, 270)]
        [int]$Angle = 90
    )

    try {
        # Load the image from the specified path
        $image = [System.Drawing.Image]::FromFile($InputPath)

        # Determine rotation type
        switch ($Angle) {
            90  { $rotateType = [System.Drawing.RotateFlipType]::Rotate90FlipNone }
            180 { $rotateType = [System.Drawing.RotateFlipType]::Rotate180FlipNone }
            270 { $rotateType = [System.Drawing.RotateFlipType]::Rotate270FlipNone }
        }

        # Apply rotation
        $image.RotateFlip($rotateType)

        # Save the rotated image
        $image.Save($OutputPath)

        Write-Host "✅ Image successfully saved to '$OutputPath'"
    }
    catch {
        Write-Error "❌ Failed to rotate image: $_"
    }
    finally {
        # Dispose of the image object to release file handle
        if ($image) { $image.Dispose() }
    }
}

# Example usage:
Rotate-Image -InputPath "C:\Users\fadzw\Downloads\sign_fadzwan-removebg-preview.png" `
             -OutputPath "C:\Users\fadzw\Downloads\rotated.jpg" `
             -Angle 270
