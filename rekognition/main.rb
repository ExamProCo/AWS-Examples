require 'aws-sdk-rekognition'
bucket = 'rekog-example-1422' # the bucket name without s3://
photo  = 'andrew.jpg' # the name of file
client   = Aws::Rekognition::Client.new region: 'us-east-1'
attrs = {
  image: {
    s3_object: {
      bucket: bucket,
      name: photo
    },
  },
  max_labels: 10
}
response = client.detect_labels attrs
puts "Detected labels for: #{photo}"
response.labels.each do |label|
puts "Label:      #{label.name}"
puts "Confidence: #{label.confidence}"
puts "Instances:"
label['instances'].each do |instance|
  box = instance['bounding_box']
  puts "  Bounding box:"
  puts "    Top:        #{box.top}"
  puts "    Left:       #{box.left}"
  puts "    Width:      #{box.width}"
  puts "    Height:     #{box.height}"
  puts "  Confidence: #{instance.confidence}"
end
puts "Parents:"
label.parents.each do |parent|
  puts "  #{parent.name}"
end
puts "------------"
puts ""
end