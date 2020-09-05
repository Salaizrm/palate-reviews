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
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      erb :'/review/index'
    else
      redirect to "/login"
    end
  end

  post '/reviews' do
    if !Helpers.is_logged_in?(session)
      redirect to "/login"
    end
      @user = Helpers.current_user(session)
      @review = Review.new(
        title: params["title"],
        brand: params["brand"],
        type: params["type"],
        rating: params["rating"],
        content: params["content"],
        user_id: @user.id)
      if @review.valid?
        @review.save
        erb :'/review/index'
      else
        redirect to '/reviews/new'
      end
    end

end
