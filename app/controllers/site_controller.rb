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
    board = setup_board(positions)
    @board = build_board_view(board, @rowsize)
  end

  def update
    game_positions = params[:positions].split(',')
    @rowsize = params[:rowsize].to_i
    user_move = params[:index].to_i
    game = create_game(@rowsize, 0)
    game.set_positions(game_positions)
    bomb_array = bomb_positions_in_string(game_positions)
    game.set_bomb_positions(bomb_array)
    ui = create_interface
    game.mark_move_on_board(user_move)
    positions = game.board_positions
    if game.game_over
      @board = build_bomb_view(positions, @rowsize)
      @disable_submit = true
      @header = ui.show_game_over_message('lose')
    else
      @board = build_board_view(positions, @rowsize)
      @disable_submit = false
    end
    @positions_to_string = positions.join(',')
    render :home
  end
end
