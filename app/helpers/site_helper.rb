module SiteHelper

  def header_class
    if @game.game_over
      @header_class = 'won' if @game.is_won?
    end
  end

  def disable_submit
    @game.game_over ? true : false
  end

  def cell_position(i,j)
    i*@rowsize + j
  end

  def form_class(cell_position)
    if (@game.bomb_positions.include? cell_position) && (@query_string == 'true')
      result = 'tagged'
    elsif (@board_array[cell_position] == 'BF') && @game.game_over
      result = 'guessed'
    elsif (@board_array[cell_position] == trophy) && @game.formatter.show_bombs == 'won'
      result = 'won'
    end
    result
  end

  def cell_class(cell_position)
    cell_class ='cell-submit'
    cell_class += ' active' if @game.board_positions[cell_position].status == 'revealed'
    cell_class
  end

  def form_status(cell_position)
    @game.board_positions[cell_position].status == 'revealed'
  end

  def trophy
    "\u{1f3c6}" || "\u{1f63a}"
  end

end
