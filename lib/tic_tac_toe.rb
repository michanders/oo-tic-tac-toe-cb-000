
class TicTacToe
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  def board
    @board
  end

  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ]

  def display_board
    puts " #{@board[0]} " + "|" + " #{@board[1]} " + "|" + " #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} " + "|" + " #{@board[4]} " + "|" + " #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} " + "|" + " #{@board[7]} " + "|" + " #{@board[8]} "
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(index, current_player = "X")
    @board[index] = current_player
  end

  def position_taken?(index)
    if @board[index] == " " || @board[index] == "" || @board[index] == nil
      false
    else
      true
    end
  end

  def valid_move?(index)
    if index.between?(0, 8)
      true
      if !position_taken?(index)
        true
      end
    elsif !index.between?(0, 8)
      false
    else
      false
    end
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.chomp
    index = input_to_index(input)
    if valid_move?(index)
      move(index, current_player)
      display_board
    else
      turn
    end
  end

  def turn_count
    counter = 0
    @board.each do |turn|
      if turn == "X" || turn == "O"
        counter += 1
      end
    end
    return counter
  end

  def current_player
    if turn_count % 2 == 0
      return "X"
    else
      return "O"
    end
  end

  def won?
    WIN_COMBINATIONS.each do |win_combination|
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]

      position_1 = @board[win_index_1]
      position_2 = @board[win_index_2]
      position_3 = @board[win_index_3]

      if position_1 == "X" && position_2 == "X" && position_3 == "X"
        win_x = true
      elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
        win_o = true
      else
        win_x = false
        win_o = false
      end
      if win_x == true || win_o == true
        return win_combination
      end
    end
    @board.each do |index|
      if index != "X" || index != "O"
        return false
      end
    end
  end

  def full?
    i = 0
    while i <= @board.length
      if @board[i] == " "
        return false
      else
        i += 1
        if i == @board.length
          return true
        end
      end
    end
  end

  def draw?
    if !won? && full?
      return true
    else
      false
    end
  end

  def over?
    if won? || draw? || full?
      return true
    end
  end


  def winner
    if draw?
      return nil
    elsif won?
      win = won?
      return @board[win[0]]
    end
  end

  def play
    until over?
      turn
    end
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
        puts "Cat's Game!"
    end
  end
end
