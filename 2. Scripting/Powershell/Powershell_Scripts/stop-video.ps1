# Get all running FFmpeg processes
$ffmpegProcesses = Get-Process -Name "ffmpeg" -ErrorAction SilentlyContinue

# Check if any FFmpeg processes are running
if ($ffmpegProcesses) {
    Write-Host "Stopping FFmpeg process..."
    Stop-Process -Name "ffmpeg" -Force
    Write-Host "FFmpeg process stopped successfully."
} else {
    Write-Host "No FFmpeg process found."
}
