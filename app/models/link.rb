require 'data_mapper'
require 'dm-postgres-adapter'
require_relative '../data_mapper_setup'

# This class corresponds to a table in the database
class Link

  include DataMapper::Resource

  has n, :tags, through: Resource
  #tags is a bit like a sub table or array of tags.

 property :id,     Serial
 property :title,  String
 property :url,    String

end
