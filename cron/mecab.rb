require "MeCab"

def extract_nouns(sentence)
  mecab = MeCab::Tagger.new(ARGV.join(" "))
  node = mecab.parseToNode(sentence)

  nouns = []
  while node do
    features = node.feature.split(",");
    kind = features.first
    if kind == "名詞"
      nouns.push(node.surface)
    end 
    node = node.next
  end
  return nouns
end

Tweet.all.each do |tweet|
  nouns = extract_nouns(tweet.text)
  nouns.each do |noun|
    word = Word.find_by_name(noun)
    unless word
      word = Word.new(
        :name  => noun,
        :count => 0
      )
    end
    word.count += 1
    if word.save
      puts word.name
    else
      puts "failed"
    end

    tweet_word = TweetWord.new(
      :tweet_id => tweet.id,
      :word_id  => word.id
    )
    tweet_word.save
  end
end
