class CreateTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|
      t.string :content
      t.integer :likes, default: 0, null: false
      t.integer :retweets, default: 0, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
