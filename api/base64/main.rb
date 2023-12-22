require "base64"

text = 'Send reinforcements'

enc   = Base64.encode64(text)
puts "encoded"
puts enc
plain = Base64.decode64(enc)
puts "decoded"
puts plain
