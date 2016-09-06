require 'data_mapper'
require 'dm-postgres-adapter'
require_relative 'data_mapper_setup'

class Tag

  include DataMapper::Resource

  property :id,   Serial
  property :tag,  String

end
