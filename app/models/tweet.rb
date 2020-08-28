class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :retweets
  paginates_per 50

end
