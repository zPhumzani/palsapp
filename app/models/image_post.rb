class ImagePost < Post
	has_attached_file :image, styles: {large: "640x480", medium: "320x240", small: "160x120"}
	validates_attachment :image, content_type: {content_type: /\Aimage\/.*\Z/}
end
