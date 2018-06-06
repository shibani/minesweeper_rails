# frozen_string_literal:true

require 'rails_helper'

RSpec.describe 'site/new.html.erb', type: :request do
  include RSpecHtmlMatchers
  include Capybara::RSpecMatchers

  it 'should have welcome h1' do
    post "/home", params: {'row_size' => 5, 'bomb_count' => 3 }

    expect(response.body).to have_selector('h1', :text => 'WELCOME TO MINESWEEPER')
  end

  it 'should have rowsize x rowsize number of submit buttons' do
    post "/home", params: {'row_size' => 5, 'bomb_count' => 3 }

    expect(response.body).to have_css('input.cell-submit', count: 25)
  end

  it 'should have a form' do
    post "/home", params: {'row_size' => 5, 'bomb_count' => 3 }

    expect(response.body).to have_selector('form')
  end

  it 'should have cells' do
    post "/home", params: {'row_size' => 5, 'bomb_count' => 3 }

    expect(response.body).to have_css('div.cell')
  end

  it 'should have a new game link' do
    post "/home", params: {'row_size' => 5, 'bomb_count' => 3 }

    expect(response.body).to have_link('New Game', class: 'reset' )
  end
end
