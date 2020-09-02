class CreateFollowerFollowings < ActiveRecord::Migration[5.2]
  def change
    create_table :follower_followings do |t|
      t.integer :user_follower_id
      t.integer :user_following_id

      t.timestamps
    end
  end
end
