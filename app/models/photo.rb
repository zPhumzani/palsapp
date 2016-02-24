class Photo < ActiveRecord::Base
   belongs_to :user
   has_attached_file :image, styles: {medium: '360x240', small: '120x100', thumb: '80x80'}
   validates_attachment :image, content_type: { content_type: /\Aimage\/.*\Z/}
end
