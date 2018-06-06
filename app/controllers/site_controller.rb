# frozen_string_literal:true

class SiteController < ApplicationController
  include Helpers

  def home
    ui = create_interface
    @header = display_header(ui)
    @query_string = params[:dev_mode]

    render :home
  end

  def new
    row_size = params[:row_size].to_i
    bomb_count = params[:bomb_count].to_i

    game = create_game(row_size, bomb_count)
    ui = create_interface
    @header = display_header(ui)
    positions = game.board_positions.map{ |el| el.content }
    @positions_to_string = positions.join(',').tr('B', '8')
    @rowsize = game.row_size

    @board = build_board_view(game, @rowsize)
    @positions_to_reveal = ''
    @flags = ''
    @query_string = params[:dev_mode]

    render :new
  end

  def update
    game_positions = params[:positions].tr('8', 'B').split(',')
    @rowsize = params[:rowsize].to_i
    user_move = params[:index].to_i
    content = params[:content]
    revealed_positions = params[:revealed]
    flag_positions = params[:flags]
    @query_string = params[:dev_mode]
    game = create_game(@rowsize, 0)
    ui = create_interface
    board_config(game, game_positions)
    update_revealed_status(game, revealed_positions)
    update_flag_status(game, flag_positions)
    move = convert_params_to_move(user_move, content, @rowsize)
    game.place_move(move)
    game.game_over = true if game.is_won?

    if game.game_over
      if game.is_won?
        @header_class = 'won'
        update_bombs_to_revealed(game)
        @header = ui.show_game_over_message('win')
        @board = build_board_view(game, 'won', nil)
      else
        update_bombs_to_revealed(game)
        @header = ui.show_game_over_message('lose')
        @board = build_board_view(game, 'show', nil)
      end
      @disable_submit = true
    else
      @board = build_board_view(game, nil, @query_string)
      @disable_submit = false
    end

    @positions_to_string = game.board_values.join(',').tr('B', '8')
    @positions_to_reveal = find_revealed(game.board_positions).join(',')
    @flags = find_flags(game.board_positions).join(',')

    render :new
  end
end
