module SiteControllerHelper
  extend ActiveSupport::Concern

  def create_interface
    Minesweeper::Messages
  end

  def create_game(row_size, bomb_count)
    Minesweeper::Game.new(row_size, bomb_count)
  end

  def display_header(ui)
    ui.welcome.tr('=', ' ').strip
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

  def bomb_positions_in_string(game_positions)
    game_positions.each_index.select { |i| game_positions[i].include? 'B' }
  end

  def find_revealed(cells_array)
    cells_array.each_index.select{ |i| cells_array[i].status == 'revealed'}
  end

  def find_flags(cells_array)
    cells_array.each_index.select{ |i| cells_array[i].flag == 'F' }
  end

  def update_revealed_status(game, revealed_positions)
    return if (revealed_positions.nil? || revealed_positions.empty?)
    revealed = convert_to_int_array(revealed_positions)
    game.set_cell_status(revealed)
  end

  def update_flag_status(game, flag_positions)
    return if (flag_positions.nil? || flag_positions.empty?)
    flags = convert_to_int_array(flag_positions)
    flags.each do |flag|
      game.board_positions[flag].add_flag
    end
  end

  def update_bombs_to_revealed(game)
    game.board_positions.each do |position|
      position.update_cell_status if position.content.include? 'B'
    end
  end

  def build_board_view(game, show_bombs=nil, query_string=nil)
    @query_string = query_string
    game.formatter.show_bombs = show_bombs
    @board_array = game.formatter.format_board_with_emoji(game.board)
    game.board_positions.each_slice(game.row_size).map.with_index do |row, row_index|
      row.map.with_index do |cell, cell_index|
        cell_position = row_index * game.row_size + cell_index

        submit_btn = @board_array[cell_position] == 'BF' ? bomb : @board_array[cell_position]

        fields_hash = {}
        fields_hash[:cell_position] = cell_position
        fields_hash[:submit_btn] = submit_btn
        fields_hash
      end
    end
  end

  def convert_to_int_array(string)
    string.split(',').map(&:to_i)
  end

  def move_is_a_flag(params)
    params == 'F'
  end

  def move_is_a_bomb(params)
    params.include? 'B'
  end

  def flag
    "\u{1f6a9}" || "\u{1f364}"
  end

  def bomb
    "\u{1f4a3}" || "\u{1f640}"
  end

  def trophy
    "\u{1f3c6}" || "\u{1f63a}"
  end
end
