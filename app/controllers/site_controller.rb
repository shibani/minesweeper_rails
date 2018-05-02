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
    positions.each_slice(row_size).with_index do |row, row_index|
      row_array = []
      row.each_with_index do |cell, cell_index|
        content = cell == 'B' ? cell : '-'
        cell_position = row_index * row_size + cell_index
        row_array << [cell_position, content]
      end
      @board << row_array
    end
    if request.post?
      redirect_to gameover_path if params[:content] == 'B'
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
