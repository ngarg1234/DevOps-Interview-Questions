import boto3

ec2_client = boto3.client('ec2')

def lambda_handler(event, context):
    instance_id = event['detail']['instance-id']
    instance_state = event['detail']['state']

    if instance_state != 'running':
        # If the instance is not running, restart it
        ec2_client.reboot_instances(InstanceIds=[instance_id])
        return f"Instance {instance_id} rebooted."
    return f"Instance {instance_id} is healthy."
