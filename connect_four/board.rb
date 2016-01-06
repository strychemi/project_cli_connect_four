
require "./disk"

class Board
  NUM_ROWS = 6
  NUM_COLS = 7
  FOUR = 4

  def initialize
    @board = Array.new(NUM_ROWS) { Array.new(NUM_COLS) }
  end

  def render
    puts
    (NUM_ROWS - 1).downto 0 do | i |
      @board[i].each do |square|
        if square.nil?
          print "o "
        else
          print "#{square.owner} "
        end
      end
      puts
    end
    puts
  end


  def valid_move?(player_input)
    @board[NUM_ROWS - 1][player_input - 1].nil? ? true : false
  end

  def place_disk ( disk, column )
    ( 0...NUM_ROWS ).each do | row |
      if !@board[row][column]
        @board[row][column] = disk
        break
      end
    end
  end

  def end_conditions?
    #check for full grid
    return true if @board.grid_full?

    #check for connect 4 along rows
    @board.each do |row|
      (0...NUM_COLS - FOUR + 1).each do |i|
        return true if check_connect_4( row[i...i+FOUR] )
      end
    end

    #check every column for 4 vertical
    (0...NUM_COLS).each do |col|
      (0...NUM_ROWS - 4 + 1).each do |row|

        col_array = []
        (0...FOUR).each do |index|
          col_array << @board[row + index][col]
        end

        return true if check_connect_4(col_array)
      end
    end

    #check diagonals



    #############
    (0..NUM_ROWS + NUM_COLS - 2).each do |diagonal|
      (0...NUM_ROWS).each do |row|
        (0...NUM_COLS).each do |col|
          if row + col == diagonal
            diagonal_array << @board[row][col]
          end
        end
      end
    end



    return false
  end

  def check_connect_4?(arr)

    # puts arr.inspect
    #checks for full array
    return false if arr.any? { |square| square == nil }

    #if array is full then check for winner
    return true if arr.all? { |square| square.owner == "1" }
    return true if arr.all? { |square| square.owner == "2" }

    #otherwise return false
    false
  end

  #return true if grid is full, else return false on empty square
  def grid_full?
    @board.each do |row|
      row.each do |square|
        return false if square == nil?
      end
    end
    true
  end

end
