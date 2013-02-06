class TweetsController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :get_user_id, :except => :search
  before_filter :authorize_user, :only => :destroy
  
  # GET /tweets/new
  # GET /tweets/new.json
  def new
    @tweet = @user.tweets.build
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tweet }
    end
  end

  # POST /tweets
  # POST /tweets.json
  def create
    @tweet = @user.tweets.build(params[:tweet])
    respond_to do |format|
      if @tweet.save
        format.html { redirect_to @user, notice: 'Tweet was successfully created.' }
        
      else
        format.html { render action: "new" }
       
      end
    end
  end

  # DELETE /tweets/1
  # DELETE /tweets/1.json
  def destroy
    @tweet = @user.tweets.find(params[:id])
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to @user, notice: 'Tweet was destroyed'}
      format.json { head :no_content }
    end
  end

  #-----------Searching users and tweets--------------#  
  def search
    @user = current_user
    @tweets = Tweet.search(params[:search],:page => params[:page], :per_page => 10)
    @tweets_count = Tweet.search(params[:search]).count
    @users_count = User.search(params[:search]).count
  end
  #----------------Retweet a tweet----------------#  
  def retweet
    @old_tweet = Tweet.find(params[:id])
    @retweet = Tweet.new
    @retweet.content = @old_tweet.content
    @retweet.user_id = current_user.id
    @retweet.parent_tweet_id = @old_tweet.id
    respond_to do |format|
      if @retweet.save
        format.html { redirect_to @user, notice: 'Retweet Done.' }
        format.json 
      else
        format.html { redirect_to @user, notice: 'Retweet not done.' }
        format.json 
      end
    end
  end
  
  private
  #-------------To get user_id as before filter for actions----------#
  def get_user_id
    @user= User.find_by_id(params[:user_id])
  end
  
  #-------------To authorize user for tweet destroy-----------------#
  def authorize_user
    if @user != current_user
      redirect_to current_user, notice: 'you are not authorized for this action.'
    end
  end
  
end