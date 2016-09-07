require 'data_mapper'
require 'dm-postgres-adapter'
require_relative '../data_mapper_setup'
require 'bcrypt'

class User

  include DataMapper::Resource

  property :id,   Serial
  property :email,  String
  property :password_digest,  String

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

end


DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/bookmark_manager_#{ENV['RACK_ENV']}")
DataMapper.finalize
