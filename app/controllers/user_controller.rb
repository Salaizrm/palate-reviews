class UserController < ApplicationController

    get '/profile' do
      if Helpers.is_logged_in?(session)
        @user = Helpers.current_user(session)
        erb :'/user/show'
      else
        redirect to '/'
      end
    end

    post '/signup' do
      @user = User.create(params)
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
          flash[:signup_error] = erb :'flash_messages/invalid_signup'
          redirect to '/'
        elsif
          @user.save
          session["user_id"] = @user.id
          redirect to '/member_homepage'
        else
          @user = @user.id
          flash[:signup_taken] = erb :'flash_messages/signup_taken'
          redirect to '/'
        end
      end

    get '/login' do
      if Helpers.is_logged_in?(session)
        redirect to '/member_homepage'
      end
      flash[:login_error] = erb :'flash_messages/login_error'
      erb :'/user/login'
    end

    post '/login' do
      @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
      redirect to '/member_homepage'
      #in review controller
    else
      flash[:login_error] = erb :'flash_messages/login_error'
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

end
