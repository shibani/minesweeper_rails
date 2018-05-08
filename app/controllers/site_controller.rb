# frozen_string_literal:true

class SiteController < ApplicationController
  include Helpers

  def home
    if request.post?
      game_positions = params[:positions].split(',')
      @rowsize = params[:rowsize].to_i
      index = params[:index]
      ui = create_interface
      #game.place move(move)
      #game.board_positions
      if params[:content] == 'B'
        positions = show_bombs(game_positions)
        @header = ui.show_game_over_message('lose')
        @disable_submit = true
      elsif params[:content] == '-'
        positions = show_user_move(game_positions, index)
      else
        positions = show_user_move(game_positions, index)
      end
      @board = build_board_view(positions, @rowsize)
      @positions_to_string = positions.join(',')
    else
      game = create_game(10, 10)
      ui = create_interface
      @header = display_header(ui)
      positions = game.board_positions
      @positions_to_string = positions.join(',')
      @rowsize = game.row_size
      board = setup_board(positions)
      @board = build_board_view(board, @rowsize)
    end
  end
end
