# frozen_string_literal: true

require_relative 'pawn'
require_relative 'board'
require_relative 'piece'

class Main

  @board = Board.new

  puts 'Chess Board Initialize, Lets start playing! '
  puts 'Type HELP for assistance'

  while (input = gets.chomp.split) != ['EXIT']
    # puts input
    case input[0]
    when 'PLACE'
      if input[1].nil?
        puts 'Wrong Input: Please provide the position that you want to place the piece at. for eg: PLACE 0,0,NORTH,WHITE'
      else
        position = input[1].split(',')
        if position[0].nil? || position[1].nil? || position[2].nil? || position[3].nil?
          puts 'Wrong Input: Please provide the position that you want to place the piece at. for eg: PLACE 0,0,NORTH,WHITE'
        else
          @board.place(position[0].to_i, position[1].to_i, position[2], position[3])
        end
      end
    when 'MOVE'
      if input[1].nil?
        puts 'Please provide the units that you want to move the piece. for eg: MOVE 2'
      else
        units = input[1].to_i
        @board.move(units)
      end
    when 'LEFT', 'RIGHT'
      @board.change_direction(input[0])
    when 'REPORT'
      @board.report
    when 'HELP'
      puts 'PLACE will put the pawn on the board in position X, Y, facing NORTH, SOUTH, EAST or WEST and Colour(White or Black)'
      puts 'The origin (0,0) can be considered to be the SOUTH WEST most corner.'
      puts 'MOVE will move the pawn one unit forward in the direction it is currently facing.'
      puts 'LEFT and RIGHT will rotate the pawn 90 degrees in the specified direction without changing the position of the pawn.'
      puts 'REPORT will announce the X,Y,F and C of the pawn. This can be in any form, but standard output is sufficient.'
      puts 'The first valid command to the pawn is a PLACE command, after that, any sequence of commands may be issued, in any order, including another PLACE command.'
      puts 'EXIT to exit the game'
    else
      puts 'Not a valid move, please choose from PLACE, LEFT, RIGHT, REPORT'
    end

  end


end
