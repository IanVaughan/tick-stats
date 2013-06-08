require 'data_mapper'

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, ENV['DATABASE_URL'] || 'postgres://postgres:postgres@127.0.0.1/tickstats')

class Stat
  include DataMapper::Resource

  property :id,         Serial
  property :date,       DateTime, required: true
  property :person,     String,   required: true
  property :hours,      Integer,  required: true

end

DataMapper.finalize.auto_upgrade!

# CREATE TABLE test (
#   id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
#   date datetime NOT NULL,
#   name VARCHAR(100) NULL,
#   hours INT(11) NULL,
#   PRIMARY KEY(id)
# );
