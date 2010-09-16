class Tweet < ActiveRecord::Base
  validates_uniqueness_of :text, :scope => [:user]
  validates_presence_of :profile_image_url
  
  belongs_to :tweet_word  
end
