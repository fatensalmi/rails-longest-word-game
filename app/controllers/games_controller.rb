require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def valid?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    json = open(url).read
    data = JSON.parse(json)
    data['found']
  end

  def include?(word_letters)
    word_letters.each do |letter|
      @letters.include?(letter)
    end
  end

  def score
    @word = params[:word]
    word_letters = @word.split
    if @letters.include?(word_letters) == false
      @result = "Sorry but #{@word} can't be built out of #{@letters}"
    elsif valid?(@word) == false
      @result = "Sorry but #{@word} does not seem to be a valid English word"
    else
      @result = "Congratulations ! #{@word}  is a valid English word !"
    end
  end
end
