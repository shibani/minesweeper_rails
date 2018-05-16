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

  def board_config(game, positions)
    game.set_positions(positions)
    bomb_array = bomb_positions_in_string(positions)
    game.set_bomb_positions(bomb_array)
  end

  def update_board_with_move(game, move)
    game.mark_move_on_board(move)
  end

  def update_board_with_flag(game, move)
    game.mark_flag_on_board(move)
  end

  def bomb_positions_in_string(game_positions)
    game_positions.each_index.select { |i| game_positions[i] == 'B' }
  end

  def build_board_view(game, row_size, show_bombs=nil)
    game.board_formatter.show_bombs = show_bombs
    board_array = game.board_formatter.format_board_with_emoji(game.board)
    game.board_positions.each_slice(row_size).map.with_index do |row, row_index|
      row.map.with_index do |cell, cell_index|
        cell_position = row_index * row_size + cell_index
        content = cell
        submit_btn = board_array[cell_position]
        [cell_position, content, submit_btn]
      end
    end
  end

  def is_won?(game)
    all_non_bomb_positions_are_marked?(game) && all_bomb_positions_are_flagged?(game)
  end

  def all_non_bomb_positions_are_marked?(game)
    board_size(game) - bomb_count(game) == move_count(game)
  end

  def all_bomb_positions_are_flagged?(game)
    bomb_count(game) == flag_count(game)
  end

  def board_size(game)
    game.board_positions.size
  end

  def bomb_count(game)
    game.board_positions.select{ |el| el.include? 'B' }.length
  end

  def move_count(game)
    game.board_positions.select{ |el| el == 'X' }.length
  end

  def flag_count(game)
    game.board_positions.select{ |el| ['BF', 'FB'].include? el }.length
  end

  def flag
    "\u{1f6a9}"
  end

  def bomb
    "\u{1f4a3}"
  end

  def trophy
    "\u{1f3c6}"
  end
end
