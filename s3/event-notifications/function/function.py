import json

def lambda_handler(event, context):
    print("<>HELLO!<>")
    # Print the string representation of the event data
    print("Received event: " + json.dumps(event, indent=2))

    # You can process the event data as needed here

    return {
        'statusCode': 200,
        'body': json.dumps('Event processed')
    }