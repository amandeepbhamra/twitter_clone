class TweetsController < ApplicationController

  
  before_filter :authenticate_user!
  before_filter :get_user, :except => :search
  before_filter :authorize_user, :only => :destroy
  

  # GET /tweets
  # GET /tweets.json
  def index

    @tweets = @user.tweets.paginate(:page => params[:page], :per_page => 5)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tweets }
    end
  end

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
        format.html { redirect_to user_tweets_path(@user), notice: 'Tweet was successfully created.' }
        format.json { render json: @tweet, status: :created, location: @tweet }
      else
        format.html { render action: "new" }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1
  # DELETE /tweets/1.json
  def destroy
    @tweet = @user.tweets.find(params[:id])
    @tweet.destroy

    respond_to do |format|
      format.html { redirect_to  user_tweets_path(@user) }
      format.json { head :no_content }
    end
  end

  #---------------------Search------------------------#  

  def search
    @tweets = Tweet.search(params[:search],:page => params[:page], :per_page => 10)
    @tweets_count = Tweet.search(params[:search]).count
    @users_count = User.search(params[:search]).count
  end

  private
  
  #-------------To get current user as before filter for actions----------#
  
  def get_user
    @user= User.find_by_id(params[:user_id])
  end

  #-------------To authorize user for editing and update-----------------#

  def authorize_user
    if @user == current_user
      render :action => :destroy
    else
      redirect_to current_user, notice: 'you are not authorized for this action.'
    end
  end
end

