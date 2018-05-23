# frozen_string_literal:true

class SiteController < ApplicationController
  include Helpers

  def home
    game = create_game(10, 10)
    ui = create_interface
    @header = display_header(ui)
    positions = game.board_positions.map{ |el| el.content }
    @positions_to_string = positions.join(',')
    @rowsize = game.row_size
    @board = build_board_view(game, @rowsize)
  end

  def update
    game_positions = params[:positions].split(',')
    @rowsize = params[:rowsize].to_i
    user_move = params[:index].to_i
    content = params[:content]
    game = create_game(@rowsize, 0)
    ui = create_interface
    board_config(game, game_positions)
    if move_is_a_flag(params[:content])
      update_board_with_flag(game, user_move)
    elsif move_is_a_bomb(params[:content])
      game.game_over = true
    else
      update_board_with_move(game, user_move)
    end
    # move = convert_params_to_move(user_move, content, @rowsize)
    # game.place_move(move)

    game.game_over = true if game.is_won?
    if game.game_over
      if game.is_won?
        @header = ui.show_game_over_message('win')
        @board = build_board_view(game, @rowsize, 'won')
      else
        @header = ui.show_game_over_message('lose')
        @board = build_board_view(game, @rowsize, 'show')
      end
      @disable_submit = true
    else
      @board = build_board_view(game, @rowsize, nil)
      @disable_submit = false
    end
    @positions_to_string = game.board_positions.join(',')

    render :home
  end
end
