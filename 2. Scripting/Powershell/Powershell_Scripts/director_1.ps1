#All installation everything will be done here on top of existing setup

#-------------------Restart failed service on failure--------------------------------#
#Define the service name
$serviceName = "Automai Database"

#Need to stop the service if it is running
Stop-Service -Name $serviceName -ErrorAction SilentlyContinue

#Set recovery options for the service using sc.exe
$scCommand = "sc.exe failure ""$serviceName"" reset= 5 actions= restart/0"
Invoke-Exprression -Command $scCommand

#Start the service
Start-Service -Name $serviceName

#-------------------End of Restart failed service on failure------------------------#

#-------------------Automation of ladding loadbalancer for Dir-1------------------------#

powershell -File "C:\scripts\Automation_Load_Balancer_Addition.ps1"

#-------------------End of Automation of ladding loadbalancer for Dir-1------------------------#