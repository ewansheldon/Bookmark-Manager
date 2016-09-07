ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
# require_relative 'models/link'
# require_relative 'models/tag'
require_relative 'data_mapper_setup'


class BookmarkManager < Sinatra::Base

  get '/users/new' do
    erb(:'users/new')
  end

  post '/users' do
    User.create(email: params[:email], password: params[:password])
    redirect '/links'
  end

  get '/welcome' do
    @user = User.last
    erb(:welcome)
  end

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/links' do #add links to db
    link = Link.create(url: params[:link_url], title: params[:bookmark_title])
    params[:tag_name].split.each do |tag|
      link.tags << Tag.create(name: tag)
    end
    link.save
    redirect '/links'
  end

  get '/tags/:tag' do
    tag = Tag.first(name: params[:tag])
    @links = tag ? tag.links : []
    erb :'links/index'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
