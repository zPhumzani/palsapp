class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  def slug_candidates
    [
      :first_name,
      [:first_name, :last_name],
      [:last_name, :first_name],
      [:first_name, :last_name, :gender],
      [:first_name, :last_name, :created_at],
    ]
  end
  around_create :create_profile
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  acts_as_messageable
  has_many :subscriptions, foreign_key: :follower_id, dependent: :destroy
  has_many :leaders, through: :subscriptions
  has_many :reverse_subscriptions, foreign_key: :leader_id, class_name: 'Subscription', dependent: :destroy
  has_many :followers, through: :reverse_subscriptions

  has_many :posts, dependent: :destroy
  has_many :text_posts, dependent: :destroy
  has_many :image_posts, dependent: :destroy

  has_many :comments, dependent: :destroy

  has_one :profile, dependent: :destroy
  delegate :date_of_birth, :location, :languages, :bio, :favorite_qoutes, :interest, :favorite_movies, :favorite_music, to: :profile

  has_many :photos, dependent: :destroy
  delegate :image_file_name, to: :photos

  validates :email, presence: true, uniqueness: true

  def following?(leader)
  	leaders.include? leader
  end

  def follow!(leader)
  	if leader != self && !following?(leader)
  		leaders << leader
  	end
  end

  def unfollow!(leader)
    subscriptions.find_by(leader.id).destroy
  end

  def timeline_user_ids
  	leader_ids + [id]
  end

  def to_s
  	"#{first_name} #{last_name}"
  end

  def mailboxer_email(object)
  	self.email
  end

  def name
  	"#{first_name} #{last_name}"
  end
end
