class TweetsController < ApplicationController
  def index
    @words = []
    words = Word.find(:all,:order => 'count DESC')
    words.each do |word|
      next unless is_meaningful(word)
      @words.push(word)
    end
  end

  def is_meaningful(word)
    if word.count < 10 ||
      word.name.length < 6 ||
      word.name =~ /同志社/ ||
      word.name =~ /\d+/ ||
      word.name =~ /[a-z]+/ ||
      word.name =~ /[A-Z]+/ ||
      word.name =~ /[Ａ-Ｚ]+/ ||
      word.name =~ /[ａ-ｚ]+/ ||
      word.name =~ /[あ-ん]+/ && word.name.length <= 6 ||
      word.name =~ /[ア-ン]+/ && word.name.length <= 6
      return false
    else
      return true
    end
  end
end
