require 'net/http'
require 'uri'
require 'json'

class DataGenerator
  def self.run base_url:
    loop do
      endpoint = DataGenerator.random_endpoint
      DataGenerator.send_req base_url, endpoint
      ts = DataGenerator.random_sleep_time
      sleep ts
    end
  end
  
  def self.random_sleep_time
    [
        0.1,# 100ms
        0.5,# 500 ms
        1,  # 1 second
    ].sample
  end
  def self.random_endpoint
    [
      { method: 'GET', path: '/john_blackthorne' },
      { method: 'PUT', path: '/lord_toranaga' },
      { method: 'POST', path: '/mariko' },
      { method: 'GET', path: '/father_alvito' },
      { method: 'GET', path: '/lady_fujiko' },
      { method: 'PUT', path: '/omi' },
      { method: 'POST', path: '/ishido' },
      { method: 'GET', path: '/lord_yabu' },
      { method: 'GET', path: '/buntaro' },
      { method: 'POST', path: '/kiku' }
    ].sample
  end

  def self.send_req base_url, endpoint
    uri = URI.parse("#{base_url}#{endpoint[:path]}")
    
    case endpoint[:method]
    when 'GET'
      request = Net::HTTP::Get.new(uri)
      request.content_type = 'application/json'
    when 'POST'
      request = Net::HTTP::Post.new(uri)
      request.content_type = 'application/json'
      #request.body = generate_random_data
    when 'PUT'
      request = Net::HTTP::Put.new(uri)
      request.content_type = 'application/json'
      #request.body = generate_random_data
    end

    # Send the request
    response = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(request)
    end

    # Print the response
    puts "Sent #{endpoint[:method]} request to #{endpoint[:path]}"
    puts "Response: #{response.code} #{response.body}"
  end
end