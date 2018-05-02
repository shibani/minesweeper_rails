module Helpers
  extend ActiveSupport::Concern

  def create_cli
    Minesweeper::CLI.new
  end

  def create_game(row_size, bomb_count)
    Minesweeper::Game.new(row_size, bomb_count)
  end

  def display_header(cli)
    cli.welcome.tr('=', ' ')
  end
end
