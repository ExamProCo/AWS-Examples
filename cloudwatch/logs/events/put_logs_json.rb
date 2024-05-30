require 'aws-sdk-cloudwatchlogs'
require 'time'
require 'pry'

class PutLogsJson
  def self.run log_group_name:, log_stream_name:, log_file_path:
    client = Aws::CloudWatchLogs::Client.new
    PutLogsJson.create_log_group(client,log_group_name)
    PutLogsJson.create_log_stream(client,log_group_name,log_stream_name)
    log_events = PutLogsJson.parse_json_log_file log_file_path
    raise "No log events to send." if log_events.empty?

    sequence_token = PutLogsJson.init_log(
      client: client,
      log_group_name: log_group_name, 
      log_stream_name: log_stream_name
    )
    PutLogsJson.log(
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

  def self.parse_json_log_file log_file_path
    log_events = []
    File.foreach(log_file_path) do |line|
      json = JSON.parse line
      timestamp = Time.strptime(json['timestamp'], "%d/%b/%Y:%H:%M:%S %z")
      timestamp = timestamp.to_i * 1000 # Convert to milliseconds
      log_events.push({
        timestamp: timestamp,
        message: line # // stringify json
      })
    end # File.foreach
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
      #binding.pry
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
    rescue => e
      puts "Error: #{e.message}"
    end
  end

end
