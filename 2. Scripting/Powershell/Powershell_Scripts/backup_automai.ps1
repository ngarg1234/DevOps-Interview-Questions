# Define Variables
$BackupSource = "C:\Automai\config"
$BackupDest = "C:\Backup\Automai_Config_Backup.zip"
$S3Bucket = "s3://your-s3-bucket-name/backups/"
$AwsCliPath = "C:\Program Files\Amazon\AWSCLI\aws.exe"  # Change if AWS CLI is installed elsewhere

# List of Services to Stop/Start
$Services = @("AutomaiDatabase", "AutomaiScheduler", "AutomaiService")

# Stop services
foreach ($service in $services) {
    $svc = Get-Service -Name $service -ErrorAction SilentlyContinue
    if ($svc -and $svc.Status -eq "Running") {
        Stop-Service -Name $service -Force
        LogMessage "Stopped service: $service"
    } else {
        LogMessage "Service not running or not found: $service"
    }
}


# Create a ZIP Archive of the Folder
Compress-Archive -Path $BackupSource -DestinationPath $BackupDest -Force
Write-Host "Backup Created at: $BackupDest"

# Upload to AWS S3
if (Test-Path $BackupDest) {
    & $AwsCliPath s3 cp $BackupDest $S3Bucket
    Write-Host "Backup uploaded to S3: $S3Bucket"
} else {
    Write-Host "Backup file not found. Upload skipped."
}

# Restart services
foreach ($service in $services) {
    Start-Service -Name $service
    LogMessage "Restarted service: $service"
}

Write-Host "Backup process completed."