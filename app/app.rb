ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
# require_relative 'models/link'
# require_relative 'models/tag'
require_relative 'data_mapper_setup'


class BookmarkManager < Sinatra::Base

  get '/' do
    redirect '/links'
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
    tag = Tag.first_or_create(name: params[:tag_name]) #checks if it exists, if not it creates the tag because you don't want to have more than one of the same tag
    link.tags << tag #this is adding the tag to the link's personal table (or array?) of tags
    link.save
    redirect '/links'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
