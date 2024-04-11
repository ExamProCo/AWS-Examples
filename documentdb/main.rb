require 'mongo'
require 'pry'

def insert_one collection
  doc = {
    name: 'Steve',
    hobbies: [ 'hiking', 'tennis', 'fly fishing' ],
    siblings: {
      brothers: 0,
      sisters: 1
    }
  }
  result = collection.insert_one(doc)
  puts result.n 
end

def insert_many collection
  docs = [ { _id: 1, name: 'Steve',
           hobbies: [ 'hiking', 'tennis', 'fly fishing' ],
           siblings: { brothers: 0, sisters: 1 } },
         { _id: 2, name: 'Sally',
                 hobbies: ['skiing', 'stamp collecting' ],
                 siblings: { brothers: 1, sisters: 0 } } ]
  result = collection.insert_many(docs)
  puts result.inserted_count
end

def query collection
  collection = client[:people]
  collection.find.each do |document|
    puts document.inspect
  end
end


client = Mongo::Client.new(
  ['mydocumentdb-982383527471.us-east-1.docdb-elastic.amazonaws.com:27017'],
  database:'test',
  ssl: true
)
#client = Mongo::Client.new('mongodb://docadmin:password@mydocumentdb-982383527471.us-east-1.docdb-elastic.amazonaws.com:27017')
db = client.database
collection = client[:people]
binding.pry