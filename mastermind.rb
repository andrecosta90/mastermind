# frozen_string_literal: true

require 'pry-byebug'
require './player'

# Build the game assuming the computer randomly selects the secret colors and the human player must guess them.
# Remember that you need to give the proper feedback on how good the guess was each turn!
#

class Mastermind
  attr_reader :n_rounds

  def initialize(n_rounds, n_colors, n_holes)
    @n_rounds = n_rounds
    @n_colors = n_colors
    @n_holes = n_holes
  end

  def self.custom_push(scores, value, inventory, item)
    inventory[item] -= 1
    scores.push(value)
  end

  def self.fitness(guess_code, secret_code)
    inventory = secret_code.tally
    scores = []
    guess_code.each_with_index do |item, index|
      if item == secret_code[index]
        custom_push(scores, 2, inventory, item)
      elsif secret_code.include?(item) && (inventory[item]).positive?
        custom_push(scores, 1, inventory, item)
      end
    end
    scores.sort.reverse
  end

  def run(codemaker, codebreaker)
    secret_code = codemaker.create_secret_code
    n_iter = 1
    loop do
      puts "Round #{n_iter} - Make a guess:"
      guess_code = codebreaker.make_guess
      # puts "Guess #{n_iter} = #{guess_code}"
      puts "Feedback => #{Mastermind.fitness(guess_code, secret_code)}\n\n"
      n_iter += 1
      break if n_iter > n_rounds || guess_code == secret_code
    end
    puts "SECRET CODE = #{secret_code}"
  end
end

n_rounds = 12
n_colors = 6
n_holes = 4

player1 = ComputerPlayer.new('player 1', n_colors, n_holes)
player2 = HumanPlayer.new('player 2')

game = Mastermind.new(n_rounds, n_colors, n_holes)
game.run(player1, player2)
