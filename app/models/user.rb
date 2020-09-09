class User < ApplicationRecord

  acts_as_token_authenticatable

  #relations
  has_many :likes, dependent: :destroy
  has_many :retweets, dependent: :destroy
  has_many :tweets, dependent: :destroy

  has_many :users_followers, foreign_key: :user_following_id, class_name: "FollowerFollowing", dependent: :destroy
  has_many :followers, through: :users_followers, source: :follower, dependent: :destroy

  has_many :following_to, foreign_key: :user_follower_id, class_name: "FollowerFollowing", dependent: :destroy
  has_many :followings, through: :following_to, source: :following, dependent: :destroy

  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  def to_s
    name
  end
end
