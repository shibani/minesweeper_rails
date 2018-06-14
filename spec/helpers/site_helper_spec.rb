require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the SiteHelper. For example:
#
# describe SiteHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe SiteHelper, type: :helper do
  before(:example) do
    @game = create_game(4, 0)
    bomb_positions = [6, 7, 11, 13]
    positions = [' ', ' ', ' ', ' ',
                 ' ', ' ', 'B', 'B',
                 ' ', ' ', ' ', 'B',
                 ' ', 'B', ' ', ' ']
    @game.set_bomb_positions(bomb_positions)
    @game.set_positions(positions)
  end

  describe '#header_class' do
    it "returns a 'won' class for the page title if the game is won" do
      move_1 = [0,0,'move']
      move_2 = [2,1,'flag']
      move_3 = [3,1,'flag']
      move_4 = [3,2,'flag']
      move_5 = [1,3,'flag']
      @game.place_move(move_1)
      @game.place_move(move_2)
      @game.place_move(move_3)
      @game.place_move(move_4)
      @game.place_move(move_5)

      expect(@game.bomb_positions).to eq([6, 7, 11, 13])
      expect(@game.board_flags).to eq([6, 7, 11, 13])
      expect(@game.game_over).to be(true)
      expect(@game.is_won?).to be(true)
      expect(helper.header_class).to eq('won')
    end
  end

  describe '#disable_submit' do
    it 'disables the form if the game is over' do
      move_1 = [0,0,'move']
      move_2 = [2,1,'move']
      @game.place_move(move_1)
      @game.place_move(move_2)

      expect(helper.disable_submit).to be(true)
    end
  end

  describe '#cell_position' do
    it 'returns the index of the cell' do
      @rowsize = @game.row_size

      expect(helper.cell_position(3,2)).to eq(14)
    end
  end

  describe '#form_class' do
    it 'returns a class to mark bomb cells if dev mode is on' do
      @query_string = 'true'
      @board_array = [' ', ' ', ' ', ' ',
                      ' ', ' ', 'B', 'B',
                      ' ', ' ', ' ', 'B',
                      ' ', 'B', ' ', ' ']

      expect(helper.form_class(6)).to eq('tagged')
    end

    it 'returns a class to mark guessed bombs if the game is over' do
      @board_array = [' ', ' ', ' ', ' ',
                      ' ', ' ', 'BF', 'B',
                      ' ', ' ', ' ', 'B',
                      ' ', 'B', ' ', ' ']
      move_1 = [0,0,'move']
      move_2 = [3,1,'move']
      @game.place_move(move_1)
      @game.place_move(move_2)

      expect(helper.form_class(6)).to eq('guessed')
    end

    it 'returns a class to mark the bomb squares as won if the game is over' do
      @game.formatter.show_bombs = 'won'
      @board_array = [' ', ' ', ' ', ' ',
                      ' ', ' ', "\u{1f3c6}", 'B',
                      ' ', ' ', ' ', 'B',
                      ' ', 'B', ' ', ' ']

      expect(helper.form_class(6)).to eq('won')
    end
  end

  describe '#cell_class' do
    it 'adds a cell-submit class to the cell' do

      expect(helper.cell_class(1)).to eq('cell-submit')
    end

    it 'adds a revealed class to the cell if a move has been placed in it' do
      move = [0,0,'move']
      @game.place_move(move)

      expect(helper.cell_class(0)).to eq('cell-submit active')
    end
  end

  describe '#form_status' do
    it 'adds disabled status to the cell if the cell has been revealed' do
      move = [0,0,'move']
      @game.place_move(move)

      expect(helper.form_status(0)).to be(true)
    end
  end

  describe '#trophy' do
    it 'returns a trophy or a winning cat' do

      expect(helper.trophy).to eq("\u{1f3c6}")
    end
  end
end
