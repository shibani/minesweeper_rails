# frozen_string_literal:true

require 'rails_helper'
include Helpers

RSpec.describe SiteController, type: :controller do
  let (:ui) {SiteController.create_interface}
  let (:game) {SiteController.create_game(5,0)}

  it 'can create a new ui object using gem methods' do
    expect(ui).to be(Minesweeper::Messages)
  end

  it 'can create a new game object using gem methods' do
    expect(game).to be_a(Minesweeper::Game)
  end

  it 'can display the header' do
    result = SiteController.display_header(ui)

    expect(result).to include('WELCOME TO MINESWEEPER')
  end

  it 'can return the bomb positions in the game' do
    positions = 'B,1,X,X,0,0,1,2,B,1,2,2,0,0,0,0'.split(",")
    result = SiteController.bomb_positions_in_string(positions)

    expect(result).to match_array([0,8])
  end

  it 'can set the boards positions' do
    positions = 'B,1,X,X,0,0,1,2,B,1,2,2,0,0,0,0'.split(",")
    SiteController.board_config(game, positions)
    expected_array = ["B","1","X","X","0","0","1","2","B","1","2","2","0","0","0","0"]

    expect(game.board_positions).to match_array(expected_array)
  end

  it 'can set the boards bomb positions' do
    positions = 'B,1,X,X,0,0,1,2,B,1,2,2,0,0,0,0'.split(",")
    SiteController.board_config(game, positions)

    expect(game.bomb_positions).to match_array([0,8])
  end

  it 'can update the board with a move' do
    SiteController.update_board_with_move(game, 13)

    expect(game.board_positions[13]).to eq('X')
  end

  it 'can update the board with a flag' do
    SiteController.update_board_with_flag(game, 20)

    expect(game.board_positions[20]).to eq('F')
  end

  it 'can build an array for the board view' do
    positions = 'B,1,X,X,0,0,1,2,B,1,2,2,0,0,0,0,1,2,B,1F,0,X,X,0,0'.split(",")
    SiteController.board_config(game, positions)
    result = SiteController.build_board_view(game, game.row_size)

    expected_array = [
      [[0, 'B', '  '], [1, '1', '1 '], [2, 'X', 'X '], [3, 'X', 'X '], [4, '0', '0 ']],
      [[5, '0', '0 '], [6, '1', '1 '], [7, '2', '2 '], [8, 'B', '  '], [9, '1', '1 ']],
      [[10, '2', '2 '], [11, '2', '2 '], [12, '0', '0 '], [13, '0', '0 '], [14, '0', '0 ']],
      [[15, '0', '0 '], [16, '1', '1 '], [17, '2', '2 '], [18, 'B', '  '], [19, '1F', "\u{1f6a9}"]],
      [[20, '0', '0 '], [21, 'X', 'X '], [22, 'X', 'X '], [23, '0', '0 '], [24, '0', '0 ']]
    ]

    expect(result).to match_array(expected_array)
  end

  it 'can return a flag' do
    result = SiteController.flag

    expect("\u{1f6a9}").to eq(result)
  end

  it 'can return a bomb' do
    result = SiteController.bomb

    expect("\u{1f4a3}").to eq(result)
  end

  it 'can return a trophy' do
    result = SiteController.trophy

    expect("\u{1f3c6}").to eq(result)
  end

  it 'can check if user move is a flag' do
    params = 'F'
    result = SiteController.move_is_a_flag(params)

    expect(result).to be(true)
  end

  it 'can check if user move is a bomb' do
    params = 'FB'
    result = SiteController.move_is_a_bomb(params)

    expect(result).to be(true)
  end
end
