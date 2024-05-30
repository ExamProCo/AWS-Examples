require 'aws-sdk-cloudwatchlogs'
require 'time'
require 'pry'

class PutLogs
  def self.run log_group_name:, log_stream_name:, log_file_path:
    client = Aws::CloudWatchLogs::Client.new
    PutLogs.create_log_group(client,log_group_name)
    PutLogs.create_log_stream(client,log_group_name,log_stream_name)
    log_events = PutLogs.parse_elf_log_file log_file_path

    puts log_events

    raise "No log events to send." if log_events.empty?

    sequence_token = PutLogs.init_log(
      client: client,
      log_group_name: log_group_name, 
      log_stream_name: log_stream_name
    )
    PutLogs.log(
      client: client,
      log_group_name: log_group_name, 
      log_stream_name: log_stream_name, 
      log_events: log_events, 
      sequence_token: sequence_token
    )
  end # self.create

  def self.create_log_group client, log_group_name
    begin
      client.create_log_group(log_group_name: log_group_name)
    rescue Aws::CloudWatchLogs::Errors::ResourceAlreadyExistsException
      # Log group already exists
    end # create_log_group
  end # self.create_log_group

  def self.create_log_stream client, log_group_name, log_stream_name
    begin
      client.create_log_stream(log_group_name: log_group_name, log_stream_name: log_stream_name)
    rescue Aws::CloudWatchLogs::Errors::ResourceAlreadyExistsException
      # Log stream already exists
    end
  end # self.create_log_stream

  def self.parse_elf_log_file log_file_path
    log_events = []
    File.foreach(log_file_path) do |line|
      if line =~ /\[(.*?)\] "(.*?)"/
        timestamp = Time.strptime("30/May/2024:07:39:43 +0000", "%d/%b/%Y:%H:%M:%S %z")
        timestamp = timestamp.to_i * 1000 # Convert to milliseconds
        message = line.strip
        log_events.push({ 
          timestamp: timestamp, 
          message: message 
        })
      end
    end
    return log_events
  end # self.parse_elf_log_file

  def self.init_log client:, log_group_name:, log_stream_name:
    sequence_token = nil
    begin
      response = client.describe_log_streams(
        log_group_name: log_group_name, 
        log_stream_name_prefix: log_stream_name
      )
      if response.log_streams.any?
        sequence_token = response.log_streams.first.upload_sequence_token
      end
    rescue Aws::CloudWatchLogs::Errors::ServiceError => e
      puts "Error describing log streams: #{e.message}"
      exit 1
    end
    return sequence_token
  end

  def self.log client:, log_group_name:, log_stream_name:, log_events:, sequence_token:
    begin
      response = client.put_log_events({
        log_group_name: log_group_name,
        log_stream_name: log_stream_name,
        log_events: log_events,
        sequence_token: sequence_token
      })
      puts "Successfully sent log events to CloudWatch Logs."
    rescue Aws::CloudWatchLogs::Errors::ServiceError => e
      puts "Error sending log events: #{e.message}"
      exit 1
    end
  end

end
