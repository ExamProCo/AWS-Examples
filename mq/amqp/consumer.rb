require 'bunny'


connection_string = "amqps://admin:Testing123456!@b-7cc94b99-4432-4a9c-ae14-9ab61199a0d7.mq.us-east-1.amazonaws.com:5671"
connection = Bunny.new(connection_string)
connection.start

channel = connection.create_channel
queue = channel.queue('hello')
begin
  queue.subscribe(block: true) do |_delivery_info, _properties, body|
    puts body
  end
rescue => e
    puts e.inspect
    channel.close
    connection.close
    exit(0)
end