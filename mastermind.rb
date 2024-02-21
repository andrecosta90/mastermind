# frozen_string_literal: true

require './player'

n_rounds = 11
n_colors = 6
n_holes = 4

p1 = HumanPlayer.new('andré')
p2 = ComputerPlayer.new('comp', n_colors, n_holes)
puts p1
# p p1.make_guess
puts
puts p2
p p2.make_guess
p p2.colors
p p2.create_secret_code
