require 'aws-sdk-textract'
require 'pry'

client = Aws::Textract::Client.new region: 'ca-central-1'
bucket = 'textract-exp-41241'
name = 'tax-doc.png'
resp = client.analyze_document({
  document: { # required
    s3_object: {
      bucket: bucket,
      name: name#,
      #version: "S3ObjectVersion",
    },
  },
  # required, accepts TABLES, FORMS, QUERIES, SIGNATURES, LAYOUT
  feature_types: ["TABLES"] 
})
#binding.pry