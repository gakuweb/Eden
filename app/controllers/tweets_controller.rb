class TweetsController < ApplicationController
  def index
    @tweets = Tweet.find(:all, :order => 'posted_at DESC')
  end

end
