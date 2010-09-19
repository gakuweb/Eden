class TweetsController < ApplicationController
  before_filter :tweet_count

  def index
    @words = []
    words = Word.find(:all,:order => 'count DESC', :conditions => ['count >= ?', 10])
    words.each do |word|
      next unless is_meaningful(word)
      @words.push(word)
    end

    @tweets = params[:word] ?
      Word.find(:first, :conditions => ['name = ?', params[:word]]).tweets.find(:all, :order =>:posted_at, :limit => 10) :
      Tweet.find(:all, :order => :posted_at, :limit => 10)
  end

  def is_meaningful(word)
    if word.name.length < 6   ||
      word.name =~ /同志社/   ||
      word.name =~ /\d+/      ||
      word.name =~ /[a-z]+/   ||
      word.name =~ /[A-Z]+/   ||
      word.name =~ /[Ａ-Ｚ]+/ ||
      word.name =~ /[ａ-ｚ]+/ ||
      word.name =~ /[あ-ん]+/ && word.name.length <= 6 ||
      word.name =~ /[ア-ン]+/ && word.name.length <= 6 # ひらがな/カタカナのみの2文字の単語を排除
      return false
    else
      return true
    end
  end

  def tweet_count
    @tweet_count = Tweet.count(:all)
  end
end
