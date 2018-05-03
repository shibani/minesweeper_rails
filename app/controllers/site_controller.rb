# frozen_string_literal:true

class SiteController < ApplicationController
  include Helpers

  def home
    cli = create_cli
    @header = display_header(cli)
    game = create_game(10, 10)
    @board = build_board_view(game)
    if request.post?
      redirect_to gameover_path if params[:content] == 'B'
    elsif request.patch?
      logger.debug 'patch'.inspect
    end
  end

  def gameover
    cli = create_cli
    @message = cli.show_game_over_message('lose')
    render :gameover
  end
end
