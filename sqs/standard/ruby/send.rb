require 'aws-sdk-sqs'

client = Aws::SQS::Client.new

queue_url = "https://sqs.ca-central-1.amazonaws.com/982383527471/sqs-standard-MyQueue-ONKfvvgwWJo2"

resp = client.send_message({
  queue_url: queue_url,
  message_body: "Hello Ruby!",
  delay_seconds: 1,
  message_attributes: {
    "Fruit" => {
      string_value: "Apple",
      data_type: "String"
    }
  }
})