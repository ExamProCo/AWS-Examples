require "digest"
require "base64"
checksum =  Digest::SHA1.file("myfile.txt").to_s
enc = Base64.encode64(checksum).force_encoding('UTF-8')
puts enc