class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  before_filter :authenticate_user!
  before_filter :get_user
  
  def index
    @user = current_user
    @tweets = @user.tweets
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show    
  @user = User.find_by_id(params[:id])
      respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
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
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  #-------------To get current user as before filter for actions----------#
  
  def get_user
    @user = User.find_by_id(params[:id])
    if @user.nil?
     redirect_to current_user
    end
    
  end

  #---------------To Follow any User-------------#
  
  def follow
    @user.follow(current_user)
    redirect_to current_user, notice: 'You are following now to ' + @user.email 
  end
  
  #---------------To Unfollow any user------------#
  
  def unfollow
    @user.stop_following(current_user)
    redirect_to current_user, notice: 'You are not following now to ' + @user.email
  end
  
  #---------------To view list of Followers------------#
  
  def followers
    @followers = @user.following_users
  end

  #-------------To view list of Followings-------------#
  
  def following
    @following = @user.user_followers
  end
end
