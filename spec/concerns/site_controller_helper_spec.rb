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
    positions = 'B,1,0,0,0,0,1,2,B,1,2,2,0,0,0,0'.split(",")
    result = SiteController.bomb_positions_in_string(positions)

    expect(result).to match_array([0,8])
  end

  # it 'can set the boards positions' do
  #   positions = 'B,1,0,0,2,2,0,0,B,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0'.split(",")
  #   SiteController.board_config(game, positions)
  #   expected_array = ['B',1,0,0,2,2,0,0,'B',1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0]
  #
  #   expect(game.board_values).to match_array(expected_array)
  # end

  it 'can set the boards bomb positions' do
    positions = 'B,1,X,X,0,0,1,2,B,1,2,2,0,0,0,0'.split(",")
    SiteController.board_config(game, positions)

    expect(game.bomb_positions).to match_array([0,8])
  end

  it 'can update the board with a move' do
    SiteController.update_board_with_move(game, 13)

    expect(game.board_positions[13].status).to eq('revealed')
  end

  it 'can update the board with a flag' do
    SiteController.update_board_with_flag(game, 20)

    expect(game.board_positions[20].flag).to eq('F')
  end

  it 'can build an array for the board view' do
    positions = 'B,1,1,1,1,1,1,1,B,1,0,0,2,2,2,0,0,1,B,1,0,0,1,1,1'.split(",")
    SiteController.board_config(game, positions)
    result = SiteController.build_board_view(game, game.row_size)


    expected_array = [0,'  ', '  ', 'cell-submit', false]
    assert_equal(result[0][0], expected_array)
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

  it 'can convert params to a user move' do
  end

  it 'can find the revealed cells if given the board' do
  end

  it 'can find the flags if given the board' do
  end

  it 'can update the revealed status of cells on the board' do
  end

  it 'can update the flag status of cells on the board' do
  end

  it 'can update the bomb positions to be revealed' do
  end
end
