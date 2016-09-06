require 'data_mapper'
require 'dm-postgres-adapter'
require_relative 'data_mapper_setup'

# This class corresponds to a table in the database
class Link

  include DataMapper::Resource


 property :id,     Serial
 property :title,  String
 property :url,    String
 property :tag,    String

end
