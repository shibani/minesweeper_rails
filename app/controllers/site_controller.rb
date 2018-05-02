# frozen_string_literal:true

class SiteController < ApplicationController
  include Helpers

  def home
    cli = create_cli
    @header = display_header(cli)
    game = create_game(10, 10)
    positions = game.board_positions
    row_size = game.row_size
    @board = []
    positions.each_slice(row_size) do |row|
      row_array = []
      row.each do |cell|
        content = cell == 'B' ? cell : '-'
        row_array << content
      end
      @board << row_array
    end
    if request.post?
      if params[:content] == 'B'
        redirect_to gameover_path
      else
        @game.place_move([3, 2, 'move'])
      end
    elsif request.patch?
      logger.debug 'patch'.inspect
    end
  end

  def gameover
    cli = create_cli
    @message = cli.show_game_over_message('lose')
    render :gameover
  end
end
