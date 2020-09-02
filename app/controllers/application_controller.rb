require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
      set :session_secret, "secret" # <= Change this, go and auto generate a password.
  end

  get "/" do
    erb :homepage
  end

end
