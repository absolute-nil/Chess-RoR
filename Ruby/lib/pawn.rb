# frozen_string_literal: true

require_relative 'board'
require_relative 'piece'

# Pawn class is a child class of piece and it will mimic the chess piece of pawn
class Pawn < Piece
  def initialize(id, x, y, face, color, board)
    @first_move = true
    @board = board
    super
  end

  def valid_fist_move?(units)
    if (units > 1 || units < -1) && !@first_move
      puts "You can't move the piece #{@id} by #{units} positions"
      return false
    end

    true
  end

  def validate_position(new_x, new_y)

    raise 'Not a valid move' if new_x.negative? || new_y.negative?

    move_within_bounds = @board.move_within_bounds?(new_x, new_y)

    return true if move_within_bounds

    raise 'Not a valid move'
  end

  def validate(units)
    return [nil, nil] unless valid_fist_move?(units)

    new_x, new_y = coordinates_after_move(units)

    [new_x, new_y] if validate_position(new_x, new_y)

  end

  def move(units, direction)
    if direction != 'FORWARD'
      puts "you can not move the Pawn in #{direction} direction "
      return nil
    end

    move_front(units)
  end

  def change_direction(direction)
    if direction != 'LEFT' && direction != 'RIGHT'
      puts 'can only change direction LEFT or RIGHT'
      return
    end

    new_face = direction_after_shift(direction)
    set_position(@x_cord, @y_cord, new_face)

  end

  private

  def move_front(units)

    new_x, new_y = validate(units)
    unless new_x.nil?
      set_position(new_x, new_y, @face)
      @first_move = false
    end
  rescue RuntimeError
    puts 'Not a valid move, Try again!'

  end
end
