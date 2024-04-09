require 'mqtt'

host = 'mqtts://admin:Testing123456!@b-6b39d23f-d358-4850-bfd4-a7784795fa05-1.mq.us-east-1.amazonaws.com:8883'
topic = 'test/topic'
message = "Hello World! MQTT"

begin
  MQTT::Client.connect(host) do |client|
    client.publish(topic,message)
  end
rescue =>  e
  puts e.inspect
end