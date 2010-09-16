class Word < ActiveRecord::Base
  validates_uniqueness_of :name

  has_many :tweet_words
  has_many :tweets, :through => :tweet_words
end
