import json
import boto3

def lambda_handler(event, context):
    # Assume event contains real-time IoT data or any data stream
    print(f"Received event: {json.dumps(event)}")
    
    # Here you could process and store the analytics
    dynamodb_client = boto3.client('dynamodb')
    table_name = 'RealTimeAnalytics'
    
    # Example: Store data into DynamoDB (real-time analysis)
    dynamodb_client.put_item(
        TableName=table_name,
        Item={
            'event_id': {'S': event['event_id']},  # Assume event has an 'event_id' field
            'data': {'S': json.dumps(event)},
            'timestamp': {'S': event['timestamp']}
        }
    )
    
    return {
        'statusCode': 200,
        'body': "Data processed and stored successfully."
    }
