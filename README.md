# README

minesweeper_rails is a rails application that runs a minesweeper game utilizing methods set up in the minesweeper_2pl gem.

For more information on Minesweeper please visit: https://en.wikipedia.org/wiki/Minesweeper_(video_game)

The game can be played by clicking on cells and the object is to guess which squares have bombs by right-clicking to place flags on them.

When all bomb locations have been guessed (have flags placed on them), the game is won.

If a bomb square is uncovered before all bomb locations are guessed then the game is lost.

* Ruby version
2.4.4

To run locally:
- clone github repo
- in terminal, cd into root of minesweeper_rails directory
- run `bundle install`
- install postgresql - https://www.postgresql.org/download/
- install postgresql gem - `gem install pg`
- check/personalize postgres settings in database.yml, i.e. add username and password if necessary
- run `rake db:create`
- to run app locally, run: `bundle exec rails s`
- navigate to localhost:3000 in your browser


* How to run tests, in root directory
- for Jasmine tests covering JS, run: `rake teaspoon`
- for ruby tests covering the controller and view, run: `rspec`
