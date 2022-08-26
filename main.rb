
arr = [["1"," | ","2"," | ","3"], ["--+---+--"], ["4"," | ","5"," | ","6"],
["--+---+--"], ["7"," | ","8"," | ","9"]] 

flag = false

module Game
  WINNING_COMBOS = [["1","2","3"], ["4","5","6"], ["7","8","9"], ["1","4","7"], 
  ["2","5","8"], ["3","6","9"], ["1","5","9"], ["3","5","7"]]

  def Game.update_grid(grid, choice, marker)
    grid.each do |row|
      if row.include?(choice)
        index = row.index(choice)
        row[index] = marker
        break
      end
    end
    grid
  end

  def Game.print_grid(grid)
    print "\n"
    grid.each do |row|
      row.each do |char|
        print char
      end
      print "\n"
    end
  end

  def Game.check_winner(player_choices)
    WINNING_COMBOS.each do |row|
      if (row - player_choices).empty?
        return true
        break
      end
    end
  end

end

class Player
  attr_accessor :name, :marker, :moves
  include Game 
  def initialize(name, marker)
    self.name = name
    self.marker = marker
    self.moves = []
  end
  def pick_square
    puts "\n#{self.name}, please pick an available square (1-9): "
    square = gets.chomp
    self.moves.push(square)
  end
end 

puts "Let's play Tic-Tac-Toe!\n"
puts "\nPlease enter the name of Player 1: "
player_one = gets.chomp
puts "\nPlease enter the name of Player 2: "
player_two = gets.chomp
puts "\nOkay, #{player_one} will be X and #{player_two} will be O!"

player_one = Player.new(player_one, "X")
player_two = Player.new(player_two, "O")

Game.print_grid(arr)

i = 0
while i <= 4


  player_one.pick_square
  arr = Game.update_grid(arr, player_one.moves[i], player_one.marker)
  Game.print_grid(arr)
  if Game.check_winner(player_one.moves) == true
    puts "\nGAME OVER! #{player_one.name} is the winner!"
    break
  end

  if i == 4
    puts "\nIt's a tie!"
    break
  end

  player_two.pick_square
  arr = Game.update_grid(arr, player_two.moves[i], player_two.marker)
  Game.print_grid(arr)
  if Game.check_winner(player_two.moves) == true
    puts "\nGAME OVER! #{player_two.name} is the winner!"
    break
  end

  i += 1
end



