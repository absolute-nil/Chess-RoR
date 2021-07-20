# frozen_string_literal: true

require 'board'
require 'pawn'

RSpec.describe Board do

  let(:board) { described_class.new }
  describe '#report' do



    context 'if piece not initialized' do
      it 'throws error in commandline' do
        expect { board.report }.to output(/you have to initialize the pawn first/).to_stdout
      end
    end

    context 'if piece is initialized' do
      before do
        board.place(0, 0, 'NORTH', 'BLACK')
      end
      it 'should report the current position of the pawn in commandline' do
        expect { board.report }.to output(/X: 0 Y: 0 F: NORTH C: BLACK/).to_stdout
      end
    end

  end

  describe '#move' do
    context 'if piece not initialized' do
      it 'throws error in commandline' do
        expect { board.report }.to output(/you have to initialize the pawn first/).to_stdout
      end
    end

    context 'if piece is initialized' do
      before(:example) do
        board.place(0, 0, 'NORTH', 'BLACK')
      end

      it 'should allow pawn to move by 1' do
        expect { board.move(1) }.to output(//).to_stdout
      end

      it 'should allow pawn to move by units greater than 2  ' do
        expect { board.move(3) }.to output(/You can't move the piece 0 by 3 positions/).to_stdout
      end

      it 'should not allow pawn to move to a coordinate that is not in the board' do
        expect { board.move(2) }.to output(/You can't move the piece 0 by 2 positions/).to_stdout
      end

      context 'first move' do

        it 'should allow pawn to move by 2' do
          expect { board.move(2) }.to output(//).to_stdout
        end

      end
      context 'not first move' do
        before do
          board.move(1)
        end

        it 'should not allow pawn to move by 2 units' do
          expect { board.move(2) }.to output(/You can't move the piece 0 by 2 positions/).to_stdout
        end

        it 'should increase the Y coordinate by 1' do
          expect { board.report }.to output(/X: 0 Y: 3 F: NORTH C: BLACK/).to_stdout
        end
      end

    end

  end

  describe '#place' do

    context 'if coordinates out of bound' do
      it 'should throw an error in commandline' do
        expect { board.place(-1, 0, 'NORTH', 'BLACK') }.to output(/not a valid input/).to_stdout
      end
    end

    context 'if input is valid' do
      let(:pieces_before_place) { described_class.instance_variable_get(:@pieces) }
      let!(:piece_id) { board.place(0, 0, 'NORTH', 'BLACK') }

      # ! Not Working
      # it 'should increase the pieces value by 1' do
      #   expect(Board.instance_variable_get(:@pieces)).to eq(1)
      # end
      # # ! Not Working
      # it 'should set the my_piece variable as the newly created piece id' do
      #   expect(Board.instance_variable_get(:@my_piece)).to eq(piece_id)
      # end

    end

  end

  describe '#change_direction' do


    context 'if piece not initialized' do
      it 'throws error in commandline' do
        expect { board.change_direction('LEFT') }.to output(/you have to initialize the pawn first/).to_stdout
      end
    end

    context 'if piece is initialized' do
      before do
        board.place(0, 0, 'NORTH', 'BLACK')
      end

      context 'direction is not valid' do
        it { expect { board.change_direction('NORTH')}.to output(/not a valid input/).to_stdout }
      end

      context 'direction is valid' do
        before do
          board.place(0, 0, 'NORTH', 'BLACK')
        end
        it 'should change the current position of the pawn' do
          expect { board.change_direction('LEFT') }.to output(//).to_stdout
        end

      end
    end

  end
end
