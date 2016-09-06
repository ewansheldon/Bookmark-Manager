require 'data_mapper'
require 'dm-postgres-adapter'

# This class corresponds to a table in the database
class Link

  include DataMapper::Resource

  has n, :tag, through: Resource


 property :id,     Serial
 property :title,  String
 property :url,    String

end


DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/bookmark_manager_#{ENV['RACK_ENV']}")
DataMapper.finalize
DataMapper.auto_upgrade!
