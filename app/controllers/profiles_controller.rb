class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: [:edit, :update, :destroy]
  layout 'users', only: :show

  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = Profile.includes(:user, :photos).all
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    @profile = Profile.find(params[:id])
    @user = User.find(@profile)
    @text_post = TextPost.new
    @user_profile = true
    @followers = @user.followers.all
    @leaders = @user.leaders.all
  end

  # GET /profiles/new
  def new
    @user = User.find(@profile)
    @profile = current_user.build_profile
  end

  # GET /profiles/1/edit
  def edit
    @user = User.find(@profile)
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = current_user.build_profile(profile_params)

    respond_to do |format|
      if @profile.save
        format.html { redirect_to user_profile_path(@profile.user), notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    if current_user
      @profile = current_user.profile
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to user_path(current_user), notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = current_user.profile
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:date_of_birth, :gender, :location, :languages, :bio, :favorite_qoutes, :interest, :favorite_movies, :favorite_music)
    end
end
