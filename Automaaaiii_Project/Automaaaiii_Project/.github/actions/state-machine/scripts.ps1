param(
    [string]$OperationType,
    [int]$DirectorNumber,
    [int]$NumberOfMachines,
    [string]$GithubRunId,
    [string]$HostNames
)
# Convert NumberOfMachines to integer and handle "0" case
$NumberOfMachines = [int]$NumberOfMachines
if ($NumberOfMachines -eq 0) {
    $NumberOfMachines = $null
}
# first find the state machine arn
$director_number = $DirectorNumber
$asgName = "a201749-automai-director-$director_number"
$AutoScalingGroupNames = @($asgName)
Write-Host "asg: $asg"
$stateMachineArn = "arn:aws:states:us-west-2:307097860667:stateMachine:TaskARNname"
Write-Host "stateMachineArn: $stateMachineArn"
if ( $OperationType -eq "botmanager-asg-desired" ) {
        $payload = @{
                "github-run-id" = $GithubRunId
                "director-number" = @($DirectorNumber)
                "number-of-machines" = $NumberOfMachines
                "autoScalingGroupNames" = $AutoScalingGroupNames
                "botmanager-asg-desired" = $true
                "botmanager-terminate-all" = $false
                "warm-pool" = $false
                "cron-expression" = $false
                "stop-director" = $false
                "start-director" = $false
                "stop-and-start-director" = $false
                "restart-director-services" = $false
                "copy-director-logs" = $false
                "measure-director-data-size" = $false
                "replace-botmanagers" = $false
                "hostnames" = $null
                "shutdown-x-machines-in-botmanager-asg" = $false
                "shutdown-all-machines-in-botmanager-asg" = $false
                "wakeup-x-machines-in-botmanager-asg" = $false
                "wakeup-all-machines-in-botmanager-asg" = $false
                "copy-botmanager-logs" = $false
                "rloader-counts-by-host" = $false
                "copy-botmanager-mp4Files-S3" = $false
            } | ConvertTo-Json
}
elseif ( $OperationType -eq "botmanager-terminate-all" ) {
        $payload = @{
                "github-run-id" = $GithubRunId
                "director-number" = @($DirectorNumber)
                "autoScalingGroupNames" = $AutoScalingGroupNames
                "number-of-machines" = $null
                "botmanager-asg-desired" = $false
                "botmanager-terminate-all" = $true
                "warm-pool" = $false
                "cron-expression" = $false
                "stop-director" = $false
                "start-director" = $false
                "stop-and-start-director" = $false
                "restart-director-services" = $false
                "copy-director-logs" = $false
                "measure-director-data-size" = $false
                "replace-botmanagers" = $false
                "hostnames" = $null
                "shutdown-x-machines-in-botmanager-asg" = $false
                "shutdown-all-machines-in-botmanager-asg" = $false
                "wakeup-x-machines-in-botmanager-asg" = $false
                "wakeup-all-machines-in-botmanager-asg" = $false
                "copy-botmanager-logs" = $false
                "rloader-counts-by-host" = $false
                "copy-botmanager-mp4Files-S3" = $false
            } | ConvertTo-Json        
}
$executionArn = aws stepfunctions start-execution --state-machine-arn $stateMachineArn --input "$payload" --query "executionArn" --output text
Write-Host "executionArn: $executionArn"
# then monitor the execution
# start stop watch
$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
do {
    Start-Sleep -Seconds 60
    $status = aws stepfunctions describe-execution --execution-arn $executionArn --query "status" --output text
    Write-Host "status: $status"
    Write-Host "Execution time: $($stopwatch.Elapsed)"
} while ($status -eq "RUNNING")
# then get the output
$output = aws stepfunctions describe-execution --execution-arn $executionArn --query "output" --output text
Write-Host "output: $output"
Write-Host "Total StateMachine Execution time: $($stopwatch.Elapsed)"
# then parse the output
if ($output -ne "None" -and $output -ne "NaN") {
    $jsonOutput = $output | ConvertFrom-Json
    Write-Host "jsonOutput: $jsonOutput"
    # then fail the step if the status code is not 200 (Ok)
    if ($jsonOutput.StatusCode -ne 200) {
        Write-Host "Step Function failed"
        exit 1
    }
}