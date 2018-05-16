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
    params = { 'content': '0', 'index': '1', 'rowsize'=>'4', 'positions': ' ,B, , , , , , , , , , , , , , '}

    params1 = { 'content': '0', 'index': '1', 'rowsize'=>'4', 'positions': ' , , , , , , , , , , , , , , , '}

    params2 = { 'content': '2', 'index': '11', 'rowsize'=>'4', 'positions': 'B,1,X,X,0,0,1,2,B,1,2,2,0,0,0,0'}

    params3 = { 'content': 'B', 'index': '0', 'rowsize'=>'4', 'positions': 'B,1,X,X,0,0,1,2,B,1,2,2,0,0,0,0'}

    params4 = { 'content': 'F', 'index': '1', 'rowsize'=>'4', 'positions': 'BF,1,X,X,0,0,1,2,B,1,2,2,0,0,0,0'}

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
      row_array = [
        [[0, 'B', '  '], [1, '1', '1 '], [2, 'X', 'X '], [3, 'X', 'X ']],
        [[4, '0', '0 '], [5, '0', '0 '], [6, '1', '1 '], [7, '2', '2 ']],
        [[8, 'B', '  '], [9, '1', '1 '], [10, '2', '2 '], [11, 'X', 'X ']],
        [[12, '0', '0 '], [13, '0', '0 '], [14, '0', '0 '], [15, '0', '0 ']]
      ]
      expect(assigns(:board)).to eq(row_array)
    end

    it 'marks the move if position is not a bomb v2' do
      post :update, params: params2

      expect(assigns(:positions_to_string)).to eq('B,1,X,X,0,0,1,2,B,1,2,X,0,0,0,0')
    end

    it 'shows the bombs if move is a bomb' do
      post :update, params: params3
      row_array = [
        [[0, 'B', "\u{1f4a3}"], [1, '1', '1 '], [2, 'X', 'X '], [3, 'X', 'X ']],
        [[4, '0', '0 '], [5, '0', '0 '], [6, '1', '1 '], [7, '2', '2 ']],
        [[8, 'B', "\u{1f4a3}"], [9, '1', '1 '], [10, '2', '2 '], [11, '2', '2 ']],
        [[12, '0', '0 '], [13, '0', '0 '], [14, '0', '0 '], [15, '0', '0 ']]
      ]
      expect(assigns(:board)).to eq(row_array)
    end

    it 'shows the game over message' do
      post :update, params: params
      expect(assigns(:header)).to eq('Game over! You lose.')
    end

    it 'can post a flag as a move' do
      post :update, params: params4
      row_array = [
        [[0, 'BF', "\u{1f6a9}"], [1, '1F', "\u{1f6a9}"], [2, 'X', 'X '], [3, 'X', 'X ']],
        [[4, '0', '0 '], [5, '0', '0 '], [6, '1', '1 '], [7, '2', '2 ']],
        [[8, 'B', '  '], [9, '1', '1 '], [10, '2', '2 '], [11, '2', '2 ']],
        [[12, '0', '0 '], [13, '0', '0 '], [14, '0', '0 '], [15, '0', '0 ']]
      ]
      expect(assigns(:board)).to eq(row_array)
    end

    it 'does not mark the position with a flag if position is a user_move' do
      post :update, params: params4
      row_array = [
        [[0, 'BF', "\u{1f6a9}"], [1, '1F', "\u{1f6a9}"], [2, 'X', 'X '], [3, 'X', 'X ']],
        [[4, '0', '0 '], [5, '0', '0 '], [6, '1', '1 '], [7, '2', '2 ']],
        [[8, 'B', '  '], [9, '1', '1 '], [10, '2', '2 '], [11, '2', '2 ']],
        [[12, '0', '0 '], [13, '0', '0 '], [14, '0', '0 '], [15, '0', '0 ']]
      ]
      expect(assigns(:board)).to eq(row_array)
    end
  end
end
