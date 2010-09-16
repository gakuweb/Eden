class Word < ActiveRecord::Base
  validates_uniqueness_of :name
  
  belongs_to :tweet_word  
end
