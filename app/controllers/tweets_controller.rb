class TweetsController < ApplicationController
  def index
    @tweets = Tweet.find(:all, :order => 'posted_at DESC')
    @word=Word.find(:all,:order=> 'count DESC')
    @tweetword=TweetWord.all
    
  end

end
