class Bookmark < Sinatra::Base

  get '/' do
    redirect '/users/new'
  end
end
