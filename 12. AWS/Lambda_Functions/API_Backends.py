import json

def lambda_handler(event, context):
    # Sample input (API Gateway event)
    body = event.get("body", {})
    
    # Example: Check if the body contains a "message" field
    message = body.get("message", "Hello World")
    
    # Simulate processing the message (e.g., saving to a database, etc.)
    response_message = f"Processed your message: {message}"
    
    return {
        'statusCode': 200,
        'body': json.dumps({
            'status': 'success',
            'response_message': response_message
        }),
        'headers': {
            'Content-Type': 'application/json'
        }
    }
