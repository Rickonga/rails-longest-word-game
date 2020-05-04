require "open-uri"

class GamesController < ApplicationController

  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @letters = params[:letters].split
    @word = (params[:word] || "").upcase
    @included = included?(@word, @letters)
    @is_english = is_english?(@word)
  end

  private

  def is_english?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    word_json = open(url).read
    json = JSON.parse(word_json)
    json['found']
  end

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end


end
