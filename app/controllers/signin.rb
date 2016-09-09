class Bookmark < Sinatra::Base

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
end
