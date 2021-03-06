class UsersController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :get_user_id, :only => [:show, :edit, :update, :follow, :unfollow, :following, :followers, :authorize_user, :me, :connect, :discover]
  before_filter :authorize_user, :only => [:edit, :update]
  before_filter :user_tweets, :only => [:show, :me]
  
  # GET /users/1
  # GET /users/1.json
  def show
    
    respond_to do |format|
      format.html # show.html.erb
      format.json 
      
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update_attributes(params[:user])
        # To notfiy user that profile is updated, a mail is sent after 2 mins #
        Notify.delay(queue: "update email notification", priority: 3, run_at: 2.minutes.from_now ).update_notification(@user)
        
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  #---------------To Follow any User-------------#
  
  def follow
    @user.follow(current_user)
     respond_to do |format|
      format.html { redirect_to current_user, notice: 'You are following now to ' + @user.email }
      format.js
    end
     
  end
  
  #---------------To Unfollow any user------------#
  
  def unfollow
    @user.stop_following(current_user)
    respond_to do |format|
      format.html { redirect_to current_user, notice: 'You are not following now to ' + @user.email }
      format.js
    end
    
  end
  
  #---------------To view list of Followers------------#
  
  def followers
    @followers = @user.following_users
  end

  #-------------To view list of Followings-------------#
  
  def following
    @following = @user.user_followers
  end
  
  #---------------------Search------------------------#  
  
  def search
    @user = current_user
    @users_searched = User.search(params[:search],:page => params[:page], :per_page => 10)
    @users_count = User.search(params[:search]).count
    @tweets_count = Tweet.search(params[:search]).count
  end
  
  #---------For getting list of user's tweets at user's me page--------#
  
  def me
    
  end

  #-----------To get list of Followable Users----------#

  def followable_users
    @followable_users = Follow.for_follower(@user).order('created_at')
  end

  #-----------To get list of user's tweets with pagination----------#
  
  def user_tweets
    @tweets = @user.tweets.paginate(:per_page => 10, :page => params[:page])
  end

  def connect
  end

  def discover
  end

  private
  #-------------To get user_id as before filter for actions----------#
  
  def get_user_id
    @user = User.find_by_id(params[:id])
    if @user.nil?
     @user ||= current_user
     redirect_to current_user
    end
  end

  #-------------To authorize user for editing and update-----------------#
  
  def authorize_user
    if !(@user == current_user)
      redirect_to current_user, notice: 'You are not authorized for this action.'
    end
  end

end