# require './app/models/main'

require 'data_mapper'

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, ENV['DATABASE_URL'] || 'postgres://postgres:postgres@127.0.0.1/quotes_board')

class Person
  include DataMapper::Resource
  # belongs_to Quote

  property :id,         Serial
  property :name,       String,     required: true, :length => 1..255
  property :avatar,     String,     :length => 255
end

DataMapper.finalize.auto_upgrade!
