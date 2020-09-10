require './config/environment'
require 'rack-flash'
class ApplicationController < Sinatra::Base
use Rack::Flash
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
      set :session_secret, "secret"

  end

  get "/" do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      erb :'/user/members_homepage'
    else
      erb :homepage
    end
  end

  get '/member_homepage' do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      erb :'/user/members_homepage'
    else
      redirect to '/login'
    end
  end

end
