class CreateOpinions < ActiveRecord::Migration
  def self.up
    create_table :opinions do |t|
      t.string :user
      t.string :text
      t.string :profile_image_url
      t.integer :reply_number
      t.string  :main_thema
      t.timestamps
    end
  end

  def self.down
    drop_table :opinions
  end
end
