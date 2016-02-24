class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:follow, :index, :show]
  before_action :set_user, only: [:show, :edit, :update, :destroy, :leaders, :followers]

  # GET /users
  # GET /users.json
  def index
    @users = User.includes(:photos, :profile).order("RANDOM()").paginate(page: params[:page], per_page: 10)
    @followers = current_user.followers.all
    @leaders = current_user.leaders.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  	@posts = @user.posts.order("created_at DESC")
    @text_post = current_user.text_posts.build
    @user_profile = true
    @show_user_right_bar = true
    @followers = @user.followers.all
    @leaders = @user.leaders.all
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'You have successfully registered. Welcome to the site!.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def followers
    @user_profile = true
  end

  def leaders 
    @user_profile = true
  end

  def follow
  	@user = User.friendly.find(params[:id])
  	if current_user.follow!(@user)
  		redirect_to @user, notice: 'Follow successful!'
  	else
  		redirect_to @user, alert: 'Error following.'
  	end
  end

  def unfollow
    @user = User.friendly.find(params[:id])
    if current_user.unfollow!(@user)
      redirect_to @user, notice: "You no longer following #{@user}"
    else
      redirect_to @user, alert: 'Error unfollowing'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
