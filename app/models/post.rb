class Post < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: Proc.new { |controller, model| controller.current_user ? controller.current_user : nil }

  belongs_to :user
  has_many :comments, dependent: :destroy 
  validates :user_id, presence: true
  validates :type, presence: true

  def cached_comment_count
  	Rails.cache.fetch [self, 'comment_count'] do 
  		comments.size
  	end
  end
  
end
