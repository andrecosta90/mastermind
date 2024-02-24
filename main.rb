# frozen_string_literal: true

# Mastermind Game
#
# This script allows you to play the Mastermind game in the terminal. You can choose to be the
# Codemaker or the Codebreaker. The Codemaker sets a secret code, and the Codebreaker tries to
# guess the code based on feedback provided by the Codemaker. The game continues for a specified
# number of rounds.
#
# To play the game, run this script in a Ruby environment.
#
# Example usage:
#   $ ruby main.rb
#
require './mastermind'

def display_rules(n_colors, n_holes)
  puts "=== SETUP GAME ===\n\n"
  puts ">> SELECT #{n_holes} VALUES FROM THE RANGE OF 1 TO #{n_colors}."
  puts "\n=================\n\n"
end

def print_options
  puts 'Do you want to be:'
  puts '  1 - Codemaker'
  puts '  2 - Codebreaker'
end

def choose_role
  print_options
  print 'Choose an option: '
  gets.chomp.to_i
end

def setup_game(n_rounds, n_colors, n_holes)
  game = Mastermind.new(n_rounds, n_colors, n_holes)
  human = HumanPlayer.new('human')
  computer = ComputerPlayer.new('computer', game)
  [game, human, computer]
end

def assign_roles(option, human, computer)
  codemaker, codebreaker = option == 1 ? [human, computer] : [computer, human]
  puts "\nYou chose to be #{option == 1 ? 'CODEMAKER' : 'CODEBREAKER'}\n\n"
  [codemaker, codebreaker]
end

def play_game(game, human, computer)
  loop do
    option = choose_role
    if [1, 2].include?(option)

      codemaker, codebreaker = assign_roles(option, human, computer)
      game.run(codemaker, codebreaker)
      break
    else
      puts 'Invalid option. Please choose 1 or 2.'
    end
  end
end

n_rounds = 12
n_colors = 6
n_holes = 4

game, human, computer = setup_game(n_rounds, n_colors, n_holes)
display_rules(n_colors, n_holes)
play_game(game, human, computer)
