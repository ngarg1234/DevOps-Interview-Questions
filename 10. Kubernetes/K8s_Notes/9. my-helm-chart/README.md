11, What are helm hooks
 
        there are different types of helm hooks, pre install, post install, pre delete, post delete, pre upgrade, post upgrade etc..
 
        suppose you want to set up a cron job before installing your chart, you can use pre install hook
        suppose you want to run a back up job after installing  a chart, you can use post install hook
 
        you can create k8s resource and use it as helm hook