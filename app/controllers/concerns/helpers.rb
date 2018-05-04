module Helpers
  extend ActiveSupport::Concern

  def create_interface
    Minesweeper::Messages
  end

  def create_game(row_size, bomb_count)
    Minesweeper::Game.new(row_size, bomb_count)
  end

  def display_header(ui)
    ui.welcome.tr('=', ' ')
  end

  def build_board_view(positions, row_size)
    board = []
    positions.each_slice(row_size).with_index do |row, row_index|
      row_array = []
      row.each_with_index do |cell, cell_index|
        content = cell == 'B' ? cell : '-'
        submit_btn = content
        cell_position = row_index * row_size + cell_index
        row_array << [cell_position, content, submit_btn]
      end
      board << row_array
    end
    board
  end

  def show_bomb_view(positions, row_size)
    board = []
    positions.each_slice(row_size).with_index do |row, row_index|
      row_array = []
      row.each_with_index do |cell, cell_index|
        content = cell == 'B' ? "\u{1f4a3}" : ' '
        cell_position = row_index * row_size + cell_index
        submit_btn = content
        row_array << [cell_position, content, submit_btn]
      end
      board << row_array
    end
    board
  end
end
