class TweetsController < ApplicationController
  # GET /tweets
  # GET /tweets.json
  before_filter :authenticate_user!
  before_filter :get_user
  before_filter :authorize_user, :only => :destroy
  def index

    @tweets = @user.tweets

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tweets }
    end
  end

  # GET /tweets/1
  # GET /tweets/1.json
  def show
    @tweet = @user.tweets.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tweet }
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

  # GET /tweets/1/edit
  

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

  # PUT /tweets/1
  # PUT /tweets/1.json
  

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

  private
  
  #-------------To get current user as before filter for actions----------#
  
  def get_user
  
    @user= User.find(params[:id])
  
  end

  #-------------To authorize user for editing and update-----------------#

  def authorize_user

    if @user == current_user
      render :action => :destroy
    else
      redirect_to user_path, notice: 'you are not authorized for this action.'
    end
  end
end
