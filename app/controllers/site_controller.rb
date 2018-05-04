# frozen_string_literal:true

class SiteController < ApplicationController
  include Helpers

  def home
    game = create_game(10, 10)
    ui = create_interface
    @header = display_header(ui)
    @board = build_board_view(game)
    if request.post?
      if params[:content] == 'B'
        @board = build_board_view(game)
      end
    elsif request.patch?
      logger.debug 'patch'.inspect
    else
    end
  end

  def gameover
    ui = create_interface
    @message = ui.show_game_over_message('lose')
    render :gameover
  end
end
