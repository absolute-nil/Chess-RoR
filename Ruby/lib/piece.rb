# frozen_string_literal: true

require_relative 'pawn'
require_relative 'board'


# Piece is the master class for all the pieces
class Piece
  @@instance_collector = []

  def self.get_instance_by_id(id)
    @@instance_collector.select { |piece| piece.id == id }
  end



  def initialize(id, x_cord, y_cord, face, color, board)

    @id = id
    @color = color
    @face = face
    @x_cord = x_cord
    @y_cord = y_cord
    @board = board
    @@instance_collector << self
  end

  # def is_overlaping?(x_cord, y_cord)
  #  Can implement it later
  # end

  attr_reader :id

  def current_position
    [@x_cord, @y_cord, @face, @color]
  end

  def current_direction
    @face
  end

  def coordinates_after_move(units)
    # only supporting straight moves for now
    return [@x_cord, @y_cord + units] if @face == 'NORTH'

    return [@x_cord, @y_cord - units] if @face == 'SOUTH'

    return [@x_cord + units, @y_cord] if @face == 'EAST'

    return [@x_cord - units, @y_cord] if @face == 'WEST'

    [-1, -1]
  end

  def direction_after_shift(direction)
    if direction == 'LEFT'
      return 'NORTH' if @face == 'EAST'
      return 'SOUTH' if @face == 'WEST'
      return 'WEST' if @face == 'NORTH'
      return 'EAST' if @face == 'SOUTH'
    end

    if direction == 'RIGHT'
      return 'NORTH' if @face == 'WEST'
      return 'SOUTH' if @face == 'EAST'
      return 'WEST' if @face == 'SOUTH'
      return 'EAST' if @face == 'NORTH'
    end

  end

  def move(_units, _direction)
    puts 'This piece is not initialized'
  end

  private

  def set_position(x_cord, y_cord, face)
    @face = face
    @x_cord = x_cord
    @y_cord = y_cord
    [@x_cord, @y_cord, @face]
  end


end
