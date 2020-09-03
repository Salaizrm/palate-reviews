require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
      set :session_secret, "secret" # <= Change this, go and auto generate a password.
  end

  get "/" do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      erb :'/review/members_homepage'
    else
      erb :homepage
    end
  end

  get '/member_homepage' do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      erb :'/review/members_homepage'
    else
      redirect to '/login'
    end
  end

  get '/profile' do
    @review = Review.all
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
    else
      redirect to '/members_homepage'
    end
    erb :'/user/show'
  end

end
