class Tweet < ActiveRecord::Base
  validates_uniqueness_of :text, :scope => [:user]
  
  has_many :tweet_words
  has_many :words, :through => :tweet_words
end
