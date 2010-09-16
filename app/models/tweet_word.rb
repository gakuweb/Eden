class TweetWord < ActiveRecord::Base
  belongs_to :tweet
  belongs_to :word
end
