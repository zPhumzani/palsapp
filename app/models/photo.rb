class Photo < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  def slug_candidates
    [
      :title,
      [:title, :created_at],
    ]
  end
   belongs_to :user
   has_attached_file :image, styles: {medium: '360x240', small: '120x100', thumb: '80x80'}
   validates_attachment :image, content_type: { content_type: /\Aimage\/.*\Z/}
end
