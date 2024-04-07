require 'aws-sdk-translate'
require 'pry'

client = Aws::Translate::Client.new

text = "Hello, This is Andrew Brown, Utilizing Amazon Translate."
resp = client.translate_text({
  text: text,
  source_language_code: "en", # required
  target_language_code: "es" # required
})
puts resp.translated_text