class Bookmark < Sinatra::Base

  delete '/sessions/end' do
    session[:user_id] = nil
    flash[:logout] = 'See you again soon!'
    redirect '/sessions/new'
  end
end
