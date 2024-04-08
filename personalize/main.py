import boto3
from botocore.config import Config

my_config = Config(
    region_name = 'ca-central-1'
)
client = boto3.client('personalize-runtime', config=my_config)

campaign_arn = 'arn:aws:personalize:ca-central-1:982383527471:campaign/my-campaign'
user_id = '127'
item_id='9910'
# context = {'itemId': 'item-id-for-context'}

resp = client.get_recommendations(
  campaignArn=campaign_arn,
  userId=user_id,
  itemId=item_id,
  # context=context
)

# Print out the recommendation results
for item in resp['itemList']:
  print(f"Item ID: {item['itemId']} Score: {item.get('score', 'N/A')}")