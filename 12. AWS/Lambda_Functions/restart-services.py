# send remote commands to director instance based on auto scaling group name
 
import json
import boto3
import os
 
def lambda_handler(event, context):
    director_number = event['Payload']['director-number']
    director_number = director_number[0]
    asg_group_name = f'a201749-automai-director-{director_number}'
    client = boto3.client('autoscaling')
    response = client.describe_auto_scaling_groups(AutoScalingGroupNames=[asg_group_name])
    instance_ids = [i['InstanceId'] for i in response['AutoScalingGroups'][0]['Instances']]
    ssm = boto3.client('ssm')
    scripts_path = 'C:\\scripts'
    for instance_id in instance_ids:
        log_response = ssm.send_command(
        InstanceIds=[instance_id],
        DocumentName="AWS-RunPowerShellScript",
        DocumentVersion="$LATEST",
        Parameters={
            'commands': [f'C:\\scripts\\restart-director-services.ps1'],
        }
        )
    print(log_response)
    return {
        'statusCode': 200,
        'body': json.dumps('Restarting director services')
    }
