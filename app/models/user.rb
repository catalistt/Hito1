class User < ApplicationRecord
  has_many :likes
  has_many :retweets
  has_many :tweets
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  def to_s
    name
  end
end
