# frozen_string_literal: true

# The main class for running the game
class Game
  attr_accessor :grid

  def initialize(player_one, player_two)
    @player_one = player_one
    @player_two = player_two
    @grid = [
      ['1', ' | ', '2', ' | ', '3'],
      ['--+---+--'],
      ['4', ' | ', '5', ' | ', '6'],
      ['--+---+--'],
      ['7', ' | ', '8', ' | ', '9']
    ]
    @available_positions = %w[1 2 3 4 5 6 7 8 9]
  end

  def play_game
    print_grid
    player = @player_one
    loop do
      make_move(player)
      print_grid
      if check_tie == true
        puts "\nIt's a tie."
        break
      end
      if check_winner(player.moves) == true
        puts "\n#{player.name} wins!"
        break
      end
      player == @player_one ? player = @player_two : player = @player_one
    end
  end

  private

  def check_tie
    return true if @available_positions.empty?
  end

  def make_move(player)
    puts "\n#{player.name}, please pick an available square (1-9): "
    square = gets.chomp
    until @available_positions.include?(square)
      puts "\nThat square is unavailable, please pick an available square (1-9): "
      square = gets.chomp
    end
    player.moves.push(square)
    @available_positions.delete(square)
    grid.each do |row|
      if row.include?(square)
        index = row.index(square)
        row[index] = player.symbol
        break
      end
    end
  end

  def print_grid
    print "\n"
    grid.each do |row|
      row.each do |char|
        print char
      end
      print "\n"
    end
  end

  def check_winner(player_choices)
    winning_combos = [
      %w[1 2 3],
      %w[4 5 6],
      %w[7 8 9],
      %w[1 4 7],
      %w[2 5 8],
      %w[3 6 9],
      %w[1 5 9],
      %w[3 5 7]
    ]
    winning_combos.each do |row|
      return true if (row - player_choices).empty?
    end
  end
end

# This class stores a player's name, symbol and moves made
class Player
  attr_reader :name, :symbol
  attr_accessor :moves

  def initialize(num)
    puts "\nPlease enter the name of Player #{num}: "
    @name = gets.chomp
    puts "\nPlayer #{num}, please enter the symbol you'd like to use: "
    @symbol = gets.chomp
    @moves = []
  end
end

p1 = Player.new(1)
p2 = Player.new(2)
tic_tac_toe = Game.new(p1, p2)
tic_tac_toe.play_game
