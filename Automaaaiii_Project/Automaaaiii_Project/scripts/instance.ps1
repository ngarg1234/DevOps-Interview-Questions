#-------------------------------------Restart Automai Database service on failure---------------------------#
# Defining the service name
$serviceName = "Automai Database"
# Need to Stop the service if it is running
Stop-Service -Name $serviceName -ErrorAction SilentlyContinue
# Set recovery options for the service using sc.exe
$scCommand = "sc.exe failure ""$serviceName"" reset= 5 actions= restart/0"
Invoke-Expression -Command $scCommand
# Start the service
Start-Service -Name $serviceName
#----------------------------------END of Restart Automai Database service on failure-------------------------#
 
#------------------Automation of adding Loadbalancers for Director-1------------------------#
 
powershell -File "C:\scripts\Automation_Load_Balancers_Addition.ps1"
 
#--------------------END of Automation of adding Loadbalancers for Director-1------------------------#