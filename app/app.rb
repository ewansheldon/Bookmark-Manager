ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require 'sinatra/flash'
require_relative 'data_mapper_setup'

class Bookmark < Sinatra::Base

  use Rack::MethodOverride

  enable :sessions
  set :session_secret, "super secret"
  register Sinatra::Flash

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  get '/' do
    redirect '/users/new'
  end

  get '/links' do
    @links = Link.all
    erb(:'links/index')
  end

  get '/links/new' do
    erb(:'links/new')
  end

  post '/links/created' do
    link = Link.new(:title => params[:title], :url => params[:url])
    params[:tag].split.each do |tag|
      link.tags << Tag.first_or_create(name: tag)
    end
    link.save
    redirect '/links'
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = (tag ? tag.links : [])
    erb(:'links/index')
  end

  get '/users/new' do
    @user = User.new
    erb(:'users/new')
  end

  post '/users' do
    @user = User.new(:email => params[:email],
                    :password => params[:password],
                    :password_confirmation => params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      redirect '/links'
    else
      flash.now[:errors] = @user.errors.full_messages
      erb :'users/new'
    end
  end

  get '/sessions/new' do
    erb :'sessions/new'
  end

  post '/sessions/new' do
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect '/links'
    else
      redirect '/sessions/new'
    end
  end

  delete '/sessions/end' do
    session[:user_id] = nil
    flash[:logout] = 'See you again soon!'
    redirect '/sessions/new'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
