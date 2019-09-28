class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :word
  attr_accessor :wrong_guesses
  attr_accessor :guesses
  def initialize(word)
    @word = word
    @wrong_guesses = ''
    @guesses = ''
  end

  def guess(l)
    if l == nil or (!(l >= 'a' and l <= 'z') and !(l >= 'A' and l <= 'Z'))
      raise ArgumentError
    end
    if @guesses.downcase.include? l.downcase or @wrong_guesses.downcase.include? l.downcase
      return false
    end
    if @word.include? l.downcase
      @guesses += l
    else
      @wrong_guesses += l
    end
    return true
  end

  def word_with_guesses()
    res = ''
    i = 0
    while i < @word.size()
      if @guesses.downcase.include? word[i].downcase
        res += word[i]
      else
        res += '-'
      end
      i += 1
    end
    return res
  end

  def check_win_or_lose()
    if word_with_guesses() == @word
      return :win
    else if wrong_guesses.size < 7
      return :play
    else
      return :lose
    end
  end
  
  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
