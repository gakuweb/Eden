class TweetWord < ActiveRecord::Base
  has_many :tweets
  has_many :words
end
