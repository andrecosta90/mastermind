# frozen_string_literal: true

require './mastermind'

n_rounds = 12
n_colors = 6
n_holes = 4
game = Mastermind.new(n_rounds, n_colors, n_holes)

loop do
  puts 'Do you wanna be a:'
  puts "\t1 - Codemaker ?"
  puts "\t2 - Codebreaker ?"
  option = gets.chomp.to_i
  # option = 1

  human = HumanPlayer.new('human')
  computer = ComputerPlayer.new('computer', game)
  if [1, 2].include?(option)
    if option == 1
      codemaker = human
      codebreaker = computer
    else
      codemaker = computer
      codebreaker = human
    end
    puts "\nCodemaker = #{codemaker}\n"
    puts "Codebreaker = #{codebreaker}\n\n"

    game.run(codemaker, codebreaker)
    # break
  else
    puts 'Invalid option'
  end
end

# player1 = ComputerPlayer.new('player 1', n_colors, n_holes)
# player2 = HumanPlayer.new('player 2')

# game = Mastermind.new(n_rounds, n_colors, n_holes)
# game.run(player1, player2)
