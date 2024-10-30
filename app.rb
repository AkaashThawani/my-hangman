require 'sinatra/base'
require 'sinatra/flash'
require_relative './lib/wordguesser_game.rb'

class WordGuesserApp < Sinatra::Base

  enable :sessions
  register Sinatra::Flash
  
  before do
    @game = session[:game] || WordGuesserGame.new('')
  end
  
  after do
    session[:game] = @game
  end
  
  get '/' do
    redirect '/new'
  end
  
  get '/new' do
    erb :new
  end
  
  post '/create' do
    word = params[:word] || WordGuesserGame.get_random_word

    @game = WordGuesserGame.new(word)
    redirect '/show'
  end
  

  post '/guess' do
    letter = params[:guess].to_s[0]
    redirect '/show'
  end
  
  get '/show' do
    erb :show 
  end
  
  get '/win' do
    erb :win 
  end
  
  get '/lose' do
    erb :lose
  end
  
end
