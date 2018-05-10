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

  def setup_board(positions)
    positions.map { ' ' }
  end

  def update_board(game, positions, move)
    game.set_positions(positions)
    bomb_array = bomb_positions_in_string(positions)
    game.set_bomb_positions(bomb_array)
    game.mark_move_on_board(move)
    game.board_positions
  end

  def bomb_positions_in_string(game_positions)
    game_positions.each_index.select { |i| game_positions[i] == 'B' }
  end

  def build_board_view(board, row_size)
    board.each_slice(row_size).map.with_index do |row, row_index|
      row.map.with_index do |cell, cell_index|
        cell_position = row_index * row_size + cell_index
        content = cell
        submit_btn = cell != 'B' ? cell : ' '
        [cell_position, content, submit_btn]
      end
    end
  end

  def build_bomb_view(board, row_size)
    board.each_slice(row_size).map.with_index do |row, row_index|
      row.map.with_index do |cell, cell_index|
        cell_position = row_index * row_size + cell_index
        content = cell
        submit_btn = cell != 'B' ? cell : "\u{1f4a3}"
        [cell_position, content, submit_btn]
      end
    end
  end
end
