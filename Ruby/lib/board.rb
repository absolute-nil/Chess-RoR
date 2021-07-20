# frozen_string_literal: true

require_relative 'pawn'
require_relative 'piece'

# Board is the chess board
class Board

  def initialize
    @origin_x = 0
    @origin_y = 0
    @size = 8
    @my_piece = nil
    @pieces = 0
  end

  def report
    if @my_piece.nil?
      puts 'you have to initialize the pawn first'
      return nil
    end
    id = @my_piece
    @piece = Piece.get_instance_by_id(id)[0]

    position = @piece.current_position
    puts "X: #{position[0]} Y: #{position[1]} F: #{position[2]} C: #{position[3]}"
  end

  def move(units, id = nil, direction = 'FORWARD')

    if @my_piece.nil?
      puts 'you have to initialize the pawn first'
      return
    end

    @piece = Piece.get_instance_by_id(@my_piece)[0]

    @piece&.move(units, direction)

  end

  def change_direction(direction, id = nil)
    if @my_piece.nil?
      puts 'you have to initialize the pawn first'
      return nil
    end

    if direction != 'LEFT' && direction != 'RIGHT'
      puts 'not a valid input'
      return nil
    end

    @piece = Piece.get_instance_by_id(@my_piece)[0]
    @piece.change_direction(direction)

  end

  # currently just creating new pawns (No other piece)
  def place(x, y, face, color)
    if move_within_bounds?(x, y) && %w[BLACK WHITE].include?(color) && %w[NORTH WEST SOUTH EAST].include?(face)
      piece = Pawn.new(@pieces, x, y, face, color, self)
      @my_piece = piece.id
      @pieces += 1
      piece.id
    else
      puts 'not a valid input'
      nil
    end
  end

  def move_within_bounds?(x, y)
    return false if (x < @origin_x) || (x >= (@origin_x + @size)) || (y < @origin_y) || (y >= (@origin_y + @size))

    true
  end

end
