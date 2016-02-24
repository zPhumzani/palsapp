class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:index,]
  def index
    user_ids = current_user.timeline_user_ids
    @activities = PublicActivity::Activity.includes(:owner).where(owner: user_ids).paginate(page: params[:page], per_page: 10).order('created_at DESC')
    @show_activity = true
  end

  def guest
  	redirect_to posts_url if user_signed_in?
  end

  def help
  end
end
