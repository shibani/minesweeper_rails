# frozen_string_literal:true

class SiteController < ApplicationController
  include Helpers

  def home
    game = create_game(10, 10)
    ui = create_interface
    @header = display_header(ui)
    positions = game.board_positions
    @positions_to_string = positions.join(',')
    @rowsize = game.row_size
    board_array = setup_board(positions)
    @board = build_board_view(board_array, @rowsize)
  end

  def update
    game_positions = params[:positions].split(',')
    @rowsize = params[:rowsize].to_i
    user_move = params[:index].to_i
    game = create_game(@rowsize, 0)
    ui = create_interface
    board_array = update_board(game, game_positions, user_move)
    if game.game_over
      @board = build_bomb_view(board_array, @rowsize)
      @disable_submit = true
      @header = ui.show_game_over_message('lose')
    else
      @board = build_board_view(board_array, @rowsize)
      @disable_submit = false
    end
    @positions_to_string = board_array.join(',')

    render :home
  end
end
