class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_activities, only: [:index, :show, :new, :edit]

  def index
  	user_ids = current_user.timeline_user_ids
  	@posts = Post.includes(:user).where(user_id: user_ids)
  	         .paginate(page: params[:page], per_page: 5).order("RANDOM()")
  	@text_post = TextPost.new
  end

  def show
  	@post = Post.includes(comments: [:user]).find(params[:id])
  	@can_moderate = (current_user == @post.user)
    @comments = @post.comments.paginate(page: params[:page], per_page: 5)
  end

  def load_activities
    user_ids = current_user.timeline_user_ids
    @activities = PublicActivity::Activity.includes(:owner, :trackable).where(owner: user_ids).order('created_at DESC').limit(5)
  end
end
