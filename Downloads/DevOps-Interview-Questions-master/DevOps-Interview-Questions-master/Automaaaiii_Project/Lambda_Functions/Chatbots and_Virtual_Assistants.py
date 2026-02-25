import json

def lambda_handler(event, context):
    # Simulate a simple chatbot response
    user_message = event.get('messages', [])
    
    if not user_message:
        return {
            'statusCode': 400,
            'body': json.dumps("No message provided.")
        }
    
    user_message = user_message[0].get('unstructured', {}).get('text', 'Hello')
    
    response_message = f"You said: {user_message}. How can I assist you further?"
    
    return {
        'statusCode': 200,
        'body': json.dumps({
            'messages': [{
                'type': 'unstructured',
                'unstructured': {
                    'text': response_message
                }
            }]
        })
    }
