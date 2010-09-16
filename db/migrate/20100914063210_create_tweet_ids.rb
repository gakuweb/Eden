class CreateTweetIds < ActiveRecord::Migration
  def self.up
    create_table :tweet_ids do |t|
      t.integer :tweet_id
      t.integer :word_id

      t.timestamps
    end
  end

  def self.down
    drop_table :tweet_ids
  end
end
