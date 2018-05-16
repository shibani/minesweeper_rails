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
    @board = build_board_view(game, @rowsize)
  end

  def update
    move = params[:content] == 'F' ? 'flag' : 'move'
    game_positions = params[:positions].split(',')
    @rowsize = params[:rowsize].to_i
    user_move = params[:index].to_i
    game = create_game(@rowsize, 0)
    ui = create_interface
    board_config(game, game_positions)
    if move == 'move'
      update_board_with_move(game, user_move)
    elsif move == 'flag'
      update_board_with_flag(game, user_move)
    end
    if game.game_over
      @board = build_board_view(game, @rowsize, "show")
      @disable_submit = true
      @header = ui.show_game_over_message('lose')
    else
      @board = build_board_view(game, @rowsize, nil)
      @disable_submit = false
    end
    @positions_to_string = game.board_positions.join(',')

    render :home
  end
end
