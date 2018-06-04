# frozen_string_literal:true

require 'rails_helper'

RSpec.describe 'site/new.html.erb', type: :view do
  include RSpecHtmlMatchers
  before { visit '/new' }

  it 'should have welcome h1' do
    expect(page).to have_content('WELCOME TO MINESWEEPER')
  end

  it 'should have a board with bombs' do
    expect(page).to have_tag('input', value: 'B')
  end

  it 'should have a form' do
    expect(page).to have_tag('form')
  end

  it 'should have cells' do
    expect(page).to have_tag('div', with: { class: 'cell' })
  end

  it 'should have a new game link' do
    expect(page).to have_link('New Game', class: 'reset' )
  end

  it 'sends a query string to the view if one is present' do
    visit '/new?dev_mode=true'

    expect(page).to have_current_path(new_path(:dev_mode => 'true'))
  end
end
