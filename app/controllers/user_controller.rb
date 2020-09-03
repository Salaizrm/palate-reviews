class UserController < ApplicationController

    post '/signup' do
      @user = User.create(params)
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
        redirect to '/'
      else
        @user.save
        session["user_id"] = @user.id
        redirect to '/member_homepage'
      end
    end

    get '/login' do
      if Helpers.is_logged_in?(session)
        redirect to '/logout'
      end
      erb :'/user/login'
    end

    post '/login' do
      @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
      redirect to '/member_homepage'
      #in review controller
    else
      redirect to '/login'
    end
  end

    get '/logout' do
      if Helpers.is_logged_in?(session)
        @user = Helpers.current_user(session)
      else
        redirect to '/'
      end
      erb :'/user/logout'
    end

    post '/logout' do
      session.clear
      redirect to '/'
    end

    get '/profile' do
      @review = Review.all
      if Helpers.is_logged_in?(session)
        @user = Helpers.current_user(session)
      else
        redirect to '/members_homepage'
      end
      erb :'/user/profile'
    end


end
