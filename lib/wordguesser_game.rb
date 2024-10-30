class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  attr_accessor :word,:guess,:wrong_guesses

  def initialize(word)
    @word = word
    @guesses = []
    @wrong_guesses = []

  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
   }
  end

  def guess(word)
	
	if (word.nil? or word == '' or /[^A-Za-z]/.match(word)!= nil)
		raise ArgumentError.new("Not a valid word")
	end 
		

	if word != nil
		word=word.downcase
	end
	  
	if (@guesses.include? word or @wrong_guesses.include? word)
		return false
	end
	
	if @word.include? word
		@guesses += word
		return true
	else
		@wrong_guesses += word
		return true
	end
  end
  
 
  def word_with_guesses
	temp = @guesses
	return @word.gsub(/[^#{temp}]/,'-')
  end

  def check_win_or_lose
	  
	if (@wrong_guesses.length >= 7)
		return :lose
	else if (word_with_guesses == @word)
		return :win
	else
		return :play
	end
  end

end
