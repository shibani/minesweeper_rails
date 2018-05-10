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

    it 'prints Welcome' do
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

    it 'assigns game board' do
      game = create_game(10, 10)
      board = game.board
      get :home
      expect(board).to be_instance_of(Minesweeper::Board)
    end

    it 'game board has expected row_size' do
      game = create_game(10, 10)
      board = game.board
      get :home
      expect(board.row_size).to be(10)
    end

    it 'game board has expected bomb_count' do
      game = create_game(10, 10)
      board = game.board
      get :home
      expect(board.bomb_count).to be(10)
    end

    it 'game board has expected number of positions' do
      game = create_game(10, 10)
      board = game.board
      get :home
      expect(board.size).to be(100)
    end
  end

  describe 'post #home' do
    subject { post 'home', params: { 'content': 'B', 'index': '36' } }

    it 'redirects to the gameover template' do
      expect(subject).to redirect_to '/gameover'
    end
  end

  describe 'get #gameover' do
    subject { get :gameover }
    it 'renders the gameover template' do
      expect(subject).to render_template(:gameover)
    end

    it 'prints the win or lose message' do
      ui = create_interface
      get :gameover
      message = ui.show_game_over_message('lose')
      expect(message).to eq('Game over! You lose.')
    end
  end
end
