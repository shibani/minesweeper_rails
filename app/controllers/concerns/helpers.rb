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
    bomb_array = bomb_positions_in_string(positions)
    game.set_bomb_positions(bomb_array)
    game.set_positions(positions)
  end

  def convert_params_to_move(move, content, rowsize)
    [
      (move % rowsize).to_i,
      (move / rowsize).to_i,
      content == 'F' ? 'flag' : 'move'
    ]
  end

  def update_board_with_move(game, move)
    game.mark_move_on_board(move)
  end

  def update_board_with_flag(game, move)
    game.mark_flag_on_board(move)
  end

  def bomb_positions_in_string(game_positions)
    game_positions.each_index.select { |i| game_positions[i].include? 'B' }
  end

  def find_revealed(cells_array)
    cells_array.each_index.select{ |i| cells_array[i].status == 'revealed' }
  end

  def find_flags(cells_array)
    cells_array.each_index.select{ |i| cells_array[i].flag == 'F' }
  end

  def update_revealed_status(game, revealed_positions)
    unless revealed_positions.nil? || revealed_positions.empty?
      revealed = revealed_positions.split(',').map(&:to_i)
      game.set_cell_status(revealed)
    end
  end

  def update_flag_status(game, flag_positions)
    unless flag_positions.nil? || flag_positions.empty?
      flags = flag_positions.split(',').map(&:to_i)
      flags.each do |flag|
        game.board_positions[flag].update_flag unless game.board_positions[flag].status == 'revealed'
      end
    end
  end

  def update_bombs_to_revealed(game)
    game.board_positions.each do |position|
      position.update_cell_status if position.content == 'B'
    end
  end

  def build_board_view(game, row_size, show_bombs=nil)
    game.board_formatter.show_bombs = show_bombs
    board_array = game.board_formatter.format_board_with_emoji(game.board)
    game.board_positions.each_slice(row_size).map.with_index do |row, row_index|
      row.map.with_index do |cell, cell_index|
        cell_position = row_index * row_size + cell_index
        content = board_array[cell_position]
        submit_btn = board_array[cell_position]
        cell_class = game.board_positions[cell_position].status == 'revealed' ? 'cell-submit active' : 'cell-submit'
        form_status =
        game.board_positions[cell_position].status == 'revealed' ? true : false
        [cell_position, content, submit_btn, cell_class, form_status]
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
