class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :retweets, dependent: :destroy
  validates :content, presence: true
  paginates_per 50

  #scope :tweets_for_me, -> { where(user_id IN current_user.following)}
  scope :tweets_for_me, ->(user) { where("user_id = ?", user)  }
  #scope :tweets_for_me, ->(user) { where(user_id IN user.following)}
end
