require 'data_mapper'
require 'dm-postgres-adapter'
require_relative '../data_mapper_setup'

class User

  include DataMapper::Resource

  property :user_id,   Serial
  property :email,  String
  property :hashed_password,  String

end


DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/bookmark_manager_#{ENV['RACK_ENV']}")
DataMapper.finalize
