# frozen_string_literal:true

require 'rails_helper'
include Helpers

RSpec.describe SiteController, type: :controller do
  describe 'GET #home' do
    subject { get :home }

    it 'returns a 200 OK status' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the home template' do
      expect(subject).to render_template('home')
    end

    it 'responds to html by default' do
      get :home
      expect(response.content_type).to eq 'text/html'
    end

    it 'assigns a ui' do
      ui = create_interface
      get :home
      expect(ui).to be(Minesweeper::Messages)
    end

    it 'sends the welcome message to the view' do
      string = '
===========================================
           WELCOME TO MINESWEEPER
===========================================

'
      expect(Minesweeper::Messages.welcome).to eq(string)
    end

    it 'assigns game' do
      game = create_game(10, 10)
      get :home
      expect(game).to be_instance_of(Minesweeper::Game)
    end

    it 'game has expected row_size' do
      game = create_game(10, 10)
      get :home
      expect(game.row_size).to be(10)
    end

    it 'game has expected bomb_count' do
      game = create_game(10, 10)
      get :home
      expect(game.bomb_count).to be(10)
    end

    it 'game has expected number of positions' do
      game = create_game(10, 10)
      get :home
      expect(game.board_positions.size).to be(100)
    end
  end

  describe 'update' do
    params = { 'content': '  ', 'index': '1', 'rowsize'=>'4', 'positions': ' ,B, , , , , , , , , , , , , , ', 'revealed': '1'}

    params1 = { 'content': '0', 'index': '1', 'rowsize'=>'4', 'positions': ' , , , , , , , , , , , , , , , '}

    params2 = { 'content': '2', 'index': '11', 'rowsize'=>'4', 'positions': 'B,1, , ,0,0,1,2,B,1,2,2,0,0,0,0'}

    params3 = { 'content': 'B', 'index': '0', 'rowsize'=>'4', 'positions': 'B,1, , ,0,0,1,2,B,1,2,2,0,0,0,0', 'revealed': '0'}

    params4 = { 'content': 'F', 'index': '1', 'rowsize'=>'4', 'positions': 'BF,1, , ,0,0,1,2,B,1,2,2,0,0,0,0'}

    params5 = { 'content': 'F', 'index': '3', 'rowsize'=>'5', 'positions': 'B,B, , , , , , ,B, , , , , , , , , ,B, , , , ,B, '}

    params6 = { 'content': 'F', 'index': '1', 'rowsize'=>'5', 'positions': 'B,B, , , , , , ,B, , , , , , , , , ,B, , , , ,B, ', 'revealed': '2,3,4,5,6,7,9,10,11,12,13,14,15,16,17,19,20,21,22,24', 'flags': '0,8,18,23'}

    params7 = { 'content': 'F', 'index': '1', 'rowsize'=>'5', 'flags': '1,2,3', 'positions': 'B,B, , , , , , ,B, , , , , , , , , ,B, , , , ,B, ', 'revealed': '10,11,12'}

    params8 = { 'content': 'F', 'index': '1', 'rowsize'=>'5', 'flags': '0,8,18,23', 'positions': 'B,B,1, , , , , ,B, , , , , , , , , ,B, , , , ,B, ',
    'revealed': '10,11,12'}

    params9 = { 'content': 'F', 'index': '3', 'rowsize'=>'5', 'positions': 'B,B, , , , , , ,B, , , , , , , , , ,B, , , , ,B, ', 'revealed':'3'}

    let (:game) {SiteController.create_game(5,5)}

    it 'returns a 200 OK status' do
      post :update, params: params
      expect(response).to have_http_status(:ok)
    end

    it 'renders the home template' do
      post :update, params: params
      expect(response).to render_template(:home)
    end

    it 'marks the move if position is not a bomb' do
      post :update, params: params2
      array = [11, '0 ', 'cell-submit active', true, nil]
      expect(assigns(:board)[2][3]).to eq(array)
    end

    it 'marks the move if position is not a bomb v2' do
      post :update, params: params2

      expect(assigns(:positions_to_string)).to eq('8,1,0,0,2,2,0,0,8,1,0,0,1,1,0,0')
    end

    it 'shows the bombs if move is a bomb' do
      post :update, params: params3

      cell_array = [0, "\u{1f4a3}", 'cell-submit active', true, nil]
      expect(assigns(:board)[0][0]).to eq(cell_array)
    end

    it 'shows the game over message' do
      post :update, params: params

      expect(assigns(:header)).to eq('Game over! You lose.')
    end

    it 'can post a flag as a move' do
      post :update, params: params4
      cell_array = [1, "\u{1f6a9}", 'cell-submit', false, nil]

      expect(assigns(:board)[0][1]).to eq(cell_array)
    end

    it 'marks the position with a flag if position is not revealed' do
      post :update, params: params5
      cell_array = [3, "\u{1f6a9}", 'cell-submit', false, nil]
      expect(assigns(:board)[0][3]).to eq(cell_array)
    end

    it 'does not mark the position with a flag if position is revealed' do
      post :update, params: params9
      cell_array = [3, '1 ', 'cell-submit active', true, nil]
      expect(assigns(:board)[0][3]).to eq(cell_array)
    end

    it 'can check if the game is won' do
      post :update, params: params6

      expect(assigns(:header)).to eq('Game over! You win!')
    end

    it 'can update the revealed positions' do
      post :update, params: params6

      expect(assigns(:board)[2][0][2]).to include('active')
    end

    it 'can send the revealed positions to the board' do
      post :update, params: params6

      expect(assigns(:positions_to_reveal)).to include('10')
    end

    it 'can check if the game is over' do
      post :update, params: params8

      expect(assigns(:header)).to eq('Game over! You win!')
    end
  end
end
