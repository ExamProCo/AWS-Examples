require 'bunny'

connection = Bunny.new
connection.start

chanel = connection.create_channel
queue = chanel.queue('hello')
exchange = channel.default_exchange


begin
    exchange.publish("Hello World!", routing_key: queue.name)
    channel.close
    connection.close
rescue => e
    puts e.inspect
    channel.close
    connection.close
    exit(0)
end