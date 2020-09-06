module TweetsHelper

  def hash_content(tweet)
    aux_array = []
    words = tweet.content.split
      words.each do |word|
        if word.start_with?('#')
          word_aux = word[1..-1]
          word = link_to(word, "/tweets?utf8=✓&q%5Bcontent_cont%5D=%23#{word_aux}&commit=Search")
        end 
        aux_array << word
      end
    aux_array.join(" ").html_safe
    end 
end
