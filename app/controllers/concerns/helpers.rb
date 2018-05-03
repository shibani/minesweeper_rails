module Helpers
  extend ActiveSupport::Concern

  def create_cli
    Minesweeper::CLI.new
  end

  def create_game(row_size, bomb_count)
    Minesweeper::Game.new(row_size, bomb_count)
  end

  def display_header(cli)
    cli.welcome.tr('=', ' ')
  end

  def build_board_view(game)
    positions = game.board_positions
    row_size = game.row_size
    board = []
    positions.each_slice(row_size).with_index do |row, row_index|
      row_array = []
      row.each_with_index do |cell, cell_index|
        content = cell == 'B' ? cell : '-'
        cell_position = row_index * row_size + cell_index
        row_array << [cell_position, content]
      end
      board << row_array
    end
    board
  end
end
