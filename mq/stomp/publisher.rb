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

dest = '/queue/test'
client.publish(dest,"Hello World! STOMP!")
client.close