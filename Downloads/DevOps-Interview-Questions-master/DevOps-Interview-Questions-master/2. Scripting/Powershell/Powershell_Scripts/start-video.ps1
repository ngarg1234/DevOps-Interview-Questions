# Define variables
$FfmpegUrl = "https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-essentials.zip"
$InstallPath = "C:\FFmpeg"
$FfmpegExe = "$InstallPath\bin\ffmpeg.exe"
$OutputFile = "C:\FFmpeg\recording.mp4"
$ScreenCaptureDevice = "gdigrab"  # Uses Windows GDI screen capture
$FrameRate = 30  # Set frame rate
$Resolution = "1920x1080"  # Change as per screen resolution
$Duration = 60  # Duration in seconds

# Function to download and extract FFmpeg
function Install-FFmpeg {
    if (!(Test-Path -Path $InstallPath)) {
        Write-Host "Downloading FFmpeg..."
        $ZipPath = "$env:TEMP\ffmpeg.zip"
        Invoke-WebRequest -Uri $FfmpegUrl -OutFile $ZipPath

        Write-Host "Extracting FFmpeg..."
        Expand-Archive -Path $ZipPath -DestinationPath $env:TEMP\ffmpeg -Force
        $ExtractedFolder = Get-ChildItem -Path "$env:TEMP\ffmpeg" | Where-Object { $_.PSIsContainer } | Select-Object -ExpandProperty FullName
        Move-Item -Path $ExtractedFolder -Destination $InstallPath
        Remove-Item -Path $ZipPath -Force
    }

    # Add FFmpeg to system PATH
    if ($env:Path -notmatch [regex]::Escape($InstallPath)) {
        $env:Path += ";$InstallPath\bin"
    }
}

# Install FFmpeg if not present
if (!(Test-Path -Path $FfmpegExe)) {
    Install-FFmpeg
}

# Start screen recording
Write-Host "Starting FFmpeg screen recording..."
Start-Process -NoNewWindow -FilePath $FfmpegExe -ArgumentList `
    "-f $ScreenCaptureDevice -framerate $FrameRate -video_size $Resolution -i desktop -t $Duration -c:v libx264 -preset ultrafast -y $OutputFile"

Write-Host "Recording started: $OutputFile"
