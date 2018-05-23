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

  # def convert_params_to_move(move, content, rowsize)
  #   [
  #     (move % rowsize).to_i,
  #     (move / rowsize).to_i,
  #     content == 'F' ? 'flag' : 'move'
  #   ]
  # end

  def update_board_with_move(game, move)
    game.mark_move_on_board(move)
  end

  def update_board_with_flag(game, move)
    game.mark_flag_on_board(move)
  end

  def bomb_positions_in_string(game_positions)
    game_positions.each_index.select { |i| game_positions[i].include? 'B' }
  end

  def build_board_view(game, row_size, show_bombs=nil)
    game.board_formatter.show_bombs = show_bombs
    board_array = game.board_formatter.format_board_with_emoji(game.board)
    game.board_positions(&:values).each_slice(row_size).map.with_index do |row, row_index|
      row.map.with_index do |cell, cell_index|
        cell_position = row_index * row_size + cell_index
        content = cell
        submit_btn = board_array[cell_position]
        [cell_position, content, submit_btn]
      end
    end
  end

  def move_is_a_flag(params)
    params == 'F'
  end

  def move_is_a_bomb(params)
    params.include? 'B'
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
