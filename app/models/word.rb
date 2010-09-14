class Word < ActiveRecord::Base
  validates_uniqueness_of :word_name
end
