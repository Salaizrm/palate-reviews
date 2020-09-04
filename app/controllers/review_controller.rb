class ReviewController < ApplicationController

  get '/review/new' do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      erb :'/review/new'
    else
      redirect to "/login"
    end
  end

  get '/reviews' do
    @review = Review.all
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      erb :'/review/index'
    else
      redirect to "/login"
    end
  end

  post '/reviews' do
    @review = Review.find_by(params[:user_id])
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      erb :'/review/index'
    else
      redirect to "/login"
    end
  end


end
