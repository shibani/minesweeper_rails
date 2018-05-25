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
    @positions_to_reveal = ''
    @flags = ''
  end

  def update
    game_positions = params[:positions].split(',')
    @rowsize = params[:rowsize].to_i
    user_move = params[:index].to_i
    content = params[:content]
    revealed_positions = params[:revealed]
    flag_positions = params[:flags]
    game = create_game(@rowsize, 0)
    ui = create_interface
    board_config(game, game_positions)
    update_revealed_status(game, revealed_positions)
    move = convert_params_to_move(user_move, content, @rowsize)
    game.place_move(move)
    update_flag_status(game, flag_positions)
    game.game_over = true if game.is_won?

    if game.game_over
      if game.is_won?
        update_bombs_to_revealed(game)
        @header = ui.show_game_over_message('win')
        @board = build_board_view(game, @rowsize, 'won')
      else
        update_bombs_to_revealed(game)
        @header = ui.show_game_over_message('lose')
        @board = build_board_view(game, @rowsize, 'show')
      end
      @disable_submit = true
    else
      @board = build_board_view(game, @rowsize, nil)
      @disable_submit = false
    end
    @positions_to_string = game.board_values.join(',')
    @positions_to_reveal = find_revealed(game.board_positions).join(',')
    @flags = find_flags(game.board_positions).join(',')
    render :home
  end
end
