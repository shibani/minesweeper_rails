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

  describe 'post #home' do
    params = { 'content': 'B', 'index': '1', 'rowsize'=>'4', 'positions': ' ,B, , , , , , , , , , , , , , '}

    params1 = { 'content': '-', 'index': '1', 'rowsize'=>'4', 'positions': ' , , , , , , , , , , , , , , , '}

    it 'returns a 200 OK status' do
      post :home, params: params
      expect(response).to have_http_status(:ok)
    end

    it 'renders the home template' do
      post :home, params: params
      expect(response).to render_template(:home)
    end

    it 'shows the game over message' do
      post :home, params: params
      expect(assigns(:header)).to eq('Game over! You lose.')
    end

    it 'can show bombs if move is a bomb' do
      post :home, params: params
      row_array = [
        [[0, ' ', ' '], [1, "\u{1f4a3}", "\u{1f4a3}"], [2, ' ', ' '], [3, ' ', ' ']],
        [[4, ' ', ' '], [5, ' ', ' '], [6, ' ', ' '], [7, ' ', ' ']],
        [[8, ' ', ' '], [9, ' ', ' '], [10, ' ', ' '], [11, ' ', ' ']],
        [[12, ' ', ' '], [13, ' ', ' '], [14, ' ', ' '], [15, ' ', ' ']]
      ]
      expect(assigns(:board)).to eq(row_array)
    end

    it 'does not show bombs if move is not a bomb' do
      post :home, params: params1
      row_array = [
        [[0, '-', '-'], [1, '-', '-'], [2, '-', '-'], [3, '-', '-']],
        [[4, '-', '-'], [5, '-', '-'], [6, '-', '-'], [7, '-', '-']],
        [[8, '-', '-'], [9, '-', '-'], [10, '-', '-'], [11, '-', '-']],
        [[12, '-', '-'], [13, '-', '-'], [14, '-', '-'], [15, '-', '-']]
      ]
      cell_array = [1, "\u{1f4a3}", "\u{1f4a3}"]
      expect(assigns(:board)).to eq(row_array)
    end
  end
end
