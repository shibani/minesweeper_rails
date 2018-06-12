module SiteHelper

  def header_class
    if @game.game_over
      @header_class = 'won' if @game.is_won?
    end
  end

  def disable_submit
    @disable_submit = @game.game_over ? true : false
  end

end
