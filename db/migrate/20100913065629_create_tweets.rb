class CreateTweets < ActiveRecord::Migration
  def self.up
    create_table :tweets do |t|
      t.string :user
      t.string :text
      t.datetime :posted_at
      t.string :profile_image_url
      t.integer :status_id
      t.timestamps
    end
  end

  def self.down
    drop_table :tweets
  end
end
