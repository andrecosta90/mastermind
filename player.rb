# frozen_string_literal: true

require './roles'

class Player
  include CodeMaker
  include CodeBreaker
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    "Name = #{name}"
  end
end

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

class ComputerPlayer < Player
  attr_reader :n_colors, :n_holes, :colors

  def initialize(name, n_colors, n_holes)
    super(name)
    @n_colors = n_colors
    @n_holes = n_holes

    @colors = (1..n_colors).map(&:to_s)
  end

  def make_guess
    # TODO: Implement min-max algorithm
    sleep(3)
    n_holes.times.map { @colors.sample }
  end

  def create_secret_code
    n_holes.times.map { @colors.sample }
    # ["1", "2", "3", "4"]
  end

  def to_s
    "COMPUTER :: #{super} || n_colors=#{n_colors} ; n_holes=#{n_holes}"
  end
end
