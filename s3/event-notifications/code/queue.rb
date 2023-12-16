require 'pry'
require 'aws-sdk-s3'
require 'aws-sdk-sqs'
require 'json'
s3client = Aws::S3::Client.new

sqsclient = Aws::SQS::Client.new
queue_url = `cd /workspace/AWS-Examples/s3/event-notifications && terraform output -raw queue_url`
resp = sqsclient.receive_message({
  queue_url: queue_url,
  attribute_names: ["All"], # accepts All, Policy, VisibilityTimeout, MaximumMessageSize, MessageRetentionPeriod, ApproximateNumberOfMessages, ApproximateNumberOfMessagesNotVisible, CreatedTimestamp, LastModifiedTimestamp, QueueArn, ApproximateNumberOfMessagesDelayed, DelaySeconds, ReceiveMessageWaitTimeSeconds, RedrivePolicy, FifoQueue, ContentBasedDeduplication, KmsMasterKeyId, KmsDataKeyReusePeriodSeconds, DeduplicationScope, FifoThroughputLimit, RedriveAllowPolicy, SqsManagedSseEnabled
  #message_attribute_names: ["MessageAttributeName"],
  max_number_of_messages: 10,
  visibility_timeout: 3,
  wait_time_seconds: 3
})
raise "no messages found" if resp.messages.size.zero?
resp.messages.each do |message|
  data = JSON.parse(message.body)
  data['Records'].each do |record|
    bucket_name = record['s3']['bucket']['name']
    object_key = record['s3']['object']['key']
    s3_resp = s3client.get_object({bucket: bucket_name,key: object_key})
    s3_data = JSON.parse(s3_resp.body.string)
    puts s3_data.inspect
    resp = sqsclient.delete_message({
      queue_url: queue_url,
      receipt_handle: message.receipt_handle
    })

  end
end
