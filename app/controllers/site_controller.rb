# frozen_string_literal:true

class SiteController < ApplicationController
  include Helpers

  def home
    if request.post?
      game_positions = params[:positions].split(",")
      game_row_size = params[:rowsize].to_i
      ui = create_interface
      #game.place move(move)
      #game.board_positions
      if params[:content] == 'B'
        @header = ui.show_game_over_message('lose')
        @board = show_bomb_view(game_positions, game_row_size)
      else
        @board = build_board_view(game_positions, game_row_size)
      end
    else
      #@book = Book.new(session[:book])
      session[:game] = create_game(10, 10)
      ui = create_interface
      @header = display_header(ui)
      positions = session[:game].board_positions
      @positions_to_string = positions.join(",")
      @rowsize = session[:game].row_size
      @board = build_board_view(positions, @rowsize)
    end
  end
end
