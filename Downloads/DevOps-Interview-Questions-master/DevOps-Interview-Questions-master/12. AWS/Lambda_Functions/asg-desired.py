# Scale Down ASG using ASG Group Name and Desired Capacity
import boto3
import os
import logging
import json
logger = logging.getLogger()
logger.setLevel(logging.INFO)
 
# get inputs from state machine
def lambda_handler(event, context):
    print(event)
    batch_index = event['batch']
    asg_machines = event['machines']
    logger.info(f'Batch Index: {batch_index}')
    logger.info(f'Scale Up ASG By: {asg_machines}')
    logger.info(f'Scaling up ASG Group by: {asg_machines}')
    director_number = event['director-number']
    logger.info(f'Director Number: {director_number}')
    if asg_machines > 0:
        # Get the ASG Group Name from the environment variable
        asg_group_name = f'a201749-automai-botmanager-{director_number}'
        # get current desired capacity
        client = boto3.client('autoscaling')
        response = client.describe_auto_scaling_groups(AutoScalingGroupNames=[asg_group_name])
        current_capacity = response['AutoScalingGroups'][0]['DesiredCapacity']
        logger.info(f'Current Desired Capacity: {current_capacity}')
        # Get the desired capacity from the environment variable
        desired_capacity = current_capacity + asg_machines
        logger.info(f'Scaling up ASG Group to: {desired_capacity} instances')
        response = client.update_auto_scaling_group(AutoScalingGroupName=asg_group_name, DesiredCapacity=int(desired_capacity))
        logger.info(response)
        return {
            'statusCode': 200,
            'body': 'ASG Group scaled up to desired capacity'
        }