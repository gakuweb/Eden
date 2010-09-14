class TweetsController < ApplicationController
  def index
    @tweets = Tweet.find(:all, :order => 'posted_at DESC', :limit => 100)
    @tweets_count = Tweet.count(:all)
  end

end
