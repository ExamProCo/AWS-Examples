require 'mqtt'

host = 'localhost'
topic 'test/topic'

begin
  MQTT::Client.connect(host) do |client|
    client.get(topic) do |topic, message|
      puts topic
      puts message
    end
  end
rescue =>  e
  puts e.inspect
end