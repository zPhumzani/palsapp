class Comment < ActiveRecord::Base
  belongs_to :post, touch: true
  belongs_to :user

  default_scope -> {order('created_at DESC')}

  validates :post_id, :user_id, :body, presence: true
end
