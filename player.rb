# frozen_string_literal: true

# This file defines the Player classes for a code-breaking game.
# It includes modules for creating secret codes and making guesses,
# and defines both a human player and a computer player.
#
# Usage:
#   - Instantiate a HumanPlayer or ComputerPlayer object with a name.
#   - Call make_guess to make a guess or create_secret_code to create a secret code.
#
require './roles'

# The Player class represents a generic player in the game.
class Player
  include CodeMaker
  include CodeBreaker
  attr_reader :name

  def initialize(name)
    @name = name
    @last_guess_code = { guess_code: nil, score: nil }
  end

  def memory_update!(guess_code, score)
    @last_guess_code[:guess_code] = guess_code
    @last_guess_code[:score] = score.sum
  end

  def to_s
    "Name = #{name}"
  end
end

# The HumanPlayer class represents a human player in the game.
class HumanPlayer < Player
  def make_guess
    read_data
  end

  def create_secret_code
    print 'Create a secret code: '
    read_data
  end

  def to_s
    "HUMAN :: #{super}"
  end

  private

  def read_data
    gets.chomp.chars
  end
end

# The ComputerPlayer class represents a computer player in the game.
class ComputerPlayer < Player
  attr_reader :game

  def initialize(name, game)
    super(name)
    @game = game
    @colors = (1..game.n_colors).map(&:to_s)
    @candidates = @colors.repeated_permutation(game.n_holes).to_a
  end

  # Makes a guess using the Knuth algorithm.
  def make_guess
    sleep(1)
    return %w[1 1 2 2] if @last_guess_code[:score].nil?

    knuth_algorithm
  end

  def create_secret_code
    game.n_holes.times.map { @colors.sample }
  end

  def to_s
    "COMPUTER :: #{super} || n_colors=#{game.n_colors} ; n_holes=#{game.n_holes}"
  end

  private

  # Implements the Knuth algorithm for making guesses.
  def knuth_algorithm
    new_candidates = []
    @candidates.each do |candidate|
      if @last_guess_code[:score] == game.fitness(candidate, @last_guess_code[:guess_code]).sum
        new_candidates.push(candidate)
      end
    end
    @candidates = new_candidates
    @candidates[0]
  end
end
