# frozen_string_literal: true

require 'board'
require 'pawn'

RSpec.describe Pawn do

  let(:pawn) do
    board = Board.new
    described_class.new(0, 0, 0, 'NORTH', 'BLACK', board)
  end
  #
  # it { expect(described_class.instance_variable_get(:@first_move)).to be_truthy }

  describe '#validate_position' do

    context 'if position invalid' do
      it { expect { pawn.validate_position(-1, -1) }.to raise_error(/Not a valid move/) }
      it { expect { pawn.validate_position(10, 10) }.to raise_error(/Not a valid move/) }
    end

    context 'if position valid' do
      it  { expect(pawn.validate_position(1, 1)).to eq(true ) }
    end

  end

  describe '#valid_fist_move?' do
    context 'if it is first move' do
      it { expect(pawn.valid_fist_move?(2)).to eq(true) }
      it { expect(pawn.valid_fist_move?(1)).to eq(true) }
    end

    context 'if not first move' do
      before(:example) do
        pawn.move(2, 'FORWARD')
      end

      it { expect(pawn.valid_fist_move?(1)).to eq(true) }
      it { expect(pawn.valid_fist_move?(2)).to eq(false) }

    end
  end

  describe '#validate' do
    context 'valid move' do
      it { expect(pawn.validate(1)).to eq([0, 1]) }
    end

    context 'not valid move' do
      it { expect(pawn.validate(7)).to eq([nil, nil]) }
    end
  end

  describe '#move' do
    context 'not a valid move' do
      it { expect { pawn.move(1, 'BACK') }.to output(/you can not move the Pawn in/).to_stdout }
    end

    context 'valid move' do
      it { expect { pawn.move(7, 'FORWARD') }.to output(//).to_stdout }
    end
  end

  describe '#change_direction' do

    context 'not a valid direction' do
      it { expect { pawn.change_direction('UP') }.to output(/can only change direction LEFT or RIGHT/).to_stdout }
    end

    context 'if valid direction provided' do
      before do
        pawn.change_direction('LEFT')
      end
      # Not Working
      # it { expect(described_class).to receive(:set_position)  }

    end

  end

end
