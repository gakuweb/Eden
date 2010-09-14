class CreateWords < ActiveRecord::Migration
  def self.up
    create_table :words do |t|
      t.string :word_name
      t.integer :word_status_id
      t.integer :count

      t.timestamps
    end
  end

  def self.down
    drop_table :words
  end
end
