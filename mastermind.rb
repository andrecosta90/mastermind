# frozen_string_literal: true

require 'pry-byebug'
require './player'

class Mastermind
  attr_reader :n_rounds, :n_colors, :n_holes

  def initialize(n_rounds, n_colors, n_holes)
    @n_rounds = n_rounds
    @n_colors = n_colors
    @n_holes = n_holes
  end

  def fitness(guess_code, secret_code)
    inventory = secret_code.tally
    scores = []

    collect_correct_position(guess_code, secret_code, scores, inventory)
    collect_wrong_position(guess_code, secret_code, scores, inventory)

    scores.sort.reverse
  end

  def run(codemaker, codebreaker)
    secret_code = codemaker.create_secret_code
    (1..n_rounds).each do |n_iter|
      puts "Round #{n_iter} - Make a guess:"

      guess_code = codebreaker.make_guess
      score = fitness(guess_code, secret_code)
      puts "Guess: #{guess_code}\nFeedback => #{score}\n\n"
      codebreaker.memory_update!(guess_code, score)

      break puts 'WINNER!' if guess_code == secret_code
    end
    puts "SECRET CODE = #{secret_code}\n\n"
  end

  private

  def custom_push(scores, value, inventory, item)
    inventory[item] -= 1
    scores.push(value)
  end

  def collect_correct_position(guess_code, secret_code, scores, inventory)
    guess_code.each_with_index do |item, index|
      custom_push(scores, 2, inventory, item) if item == secret_code[index]
    end
  end

  def collect_wrong_position(guess_code, secret_code, scores, inventory)
    guess_code.each_with_index do |item, index|
      if item != secret_code[index] && secret_code.include?(item) && (inventory[item]).positive?
        custom_push(scores, 1, inventory, item)
      end
    end
  end
end
