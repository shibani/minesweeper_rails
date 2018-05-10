# frozen_string_literal:true

class SiteController < ApplicationController
  include Helpers

  def home
    game = create_game(10, 10)
    ui = create_interface
    @header = display_header(ui)
    @board = build_board_view(game)
    if request.post?
      redirect_to gameover_path if params[:content] == 'B'
    elsif request.patch?
      logger.debug 'patch'.inspect
    end
  end

  def gameover
    ui = create_interface
    @message = ui.show_game_over_message('lose')
    render :gameover
  end
end
