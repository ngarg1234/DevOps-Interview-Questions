import boto3

ec2_client = boto3.client('ec2')

def lambda_handler(event, context):
    action = event.get('action', 'start')  # action can be 'start' or 'stop'
    instance_ids = event.get('instance_ids', ['i-xxxxxxxxxxxxxxxxx'])

    if action == 'start':
        ec2_client.start_instances(InstanceIds=instance_ids)
        return f"Started EC2 instances: {instance_ids}"
    elif action == 'stop':
        ec2_client.stop_instances(InstanceIds=instance_ids)
        return f"Stopped EC2 instances: {instance_ids}"
    else:
        return "Invalid action"
