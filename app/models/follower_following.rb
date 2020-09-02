class FollowerFollowing < ApplicationRecord
  belongs_to :follower, foreign_key: :user_follower_id, class_name: "User"
  belongs_to :following, foreign_key: :user_following_id, class_name: "User"
end
