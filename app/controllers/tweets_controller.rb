class TweetsController < ApplicationController
  def index

    @tweets = Tweet.find(:all, :order => 'posted_at DESC', :limit => 100)
    @tweets_count = Tweet.count(:all)
    @word = Word.find(:all,:order=> 'count DESC')
    @tweetword = TweetWord.all
    @arrayword = Array.new(Word.count(:all)).map{ Array.new(3)}  
	@count = 0
	@word.each do |a|
	  if a.name=~/同志社/||a.name=~/doshisha/||a.name=~/[0-9+]/||a.name=~/[a-z+]/||a.name=~/[A-Z+]/||a.name=~/[Ａ-Ｚ]/||a.name=~/[ａ-ｚ]/||a.name=~/[あ-ん]/&&a.name.length==6||a.name=~/[ア-ン]/&&a.name.length==6

	  elsif a.name.length>=6&&a.count>=10
	  	@arrayword[@count][0] = a.id
	    @arrayword[@count][1] = a.name
	    @arrayword[@count][2] = a.count
	    @count += 1
	  end
	end
  end
end
