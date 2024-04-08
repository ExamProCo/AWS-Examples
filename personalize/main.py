import boto3

personalize_runtime = boto3.client('personalize-runtime')

campaign_arn = 'your-campaign-arn-here'
user_id = 'user-id-for-recommendations'
# context = {'itemId': 'item-id-for-context'}

response = personalize_runtime.get_recommendations(
    campaignArn=campaign_arn,
    userId=user_id,
    # context=context
)

# Print out the recommendation results
for item in response['itemList']:
    print(f"Item ID: {item['itemId']} Score: {item.get('score', 'N/A')}")