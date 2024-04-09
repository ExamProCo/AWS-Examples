require 'stomp'

login = ''
passcode = ''
host = ''
port = ''

config = {
  hosts: [
    login: login, 
    passcode: passcode, 
    host: host, 
    port: port, 
    ssl: false
  ]

}
client = Stomp::Client.new(config)
client.subscribe(dest) do |message|
  client.acknowledge(message)
end

sleep