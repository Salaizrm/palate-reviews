class ReviewController < ApplicationController

  get '/reviews' do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      erb :'/review/index'
    else
      flash[:login_error] = erb :'flash_messages/login_error'
      redirect to "/login"
    end
  end

  get '/review/new' do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      erb :'/review/new'
    else
      flash[:login_error] = erb :'flash_messages/login_error'
      redirect to "/login"
    end
  end

  post '/reviews' do
    if !Helpers.is_logged_in?(session)
      flash[:login_error] = erb :'flash_messages/login_error'
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
           erb :'/review/show'
         else
           flash[:form_error] = erb :'flash_messages/invalid_form'
           redirect to '/review/new'
         end
       end

  get '/review/:id' do
    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    end
    @review = Review.find_by(params[:id])
    erb :'/tweets/show'
  end

  get '/review/:id/edit' do
    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    end
      @review = Review.find(params[:id])
    if @review.user == Helpers.current_user(session)
        erb :'/review/edit'
    else
      redirect to '/login'
    end
  end

  patch '/review/:id' do
    @review = Review.find_by(params[:id])
    if params[:title] == "" || params[:brand] == "" || params[:type] == "" || params[:rating] == "" || params[:content] == ""
      redirect to "/review/#{@review.id}/edit"
    end
      @review.update(title: params["title"])
      @review.update(brand: params["brand"])
      @review.update(type: params["type"])
      @review.update(rating: params["rating"])
      @review.update(content: params["content"])
      @tweet.save
    redirect to "/tweets/#{@tweet.id}"
  end

  delete '/review/:id/delete' do
    if Helpers.is_logged_in?(session)
      @review = Review.find(params[:id])
      if @review.user == Helpers.current_user(session)
        @review = Review.find_by(params[:id])
        @review.delete
        redirect to '/reviews'
      else
        redirect to '/reviews'
      end
    else
      redirect to '/login'
    end
  end


end
