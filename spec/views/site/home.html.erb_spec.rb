# frozen_string_literal:true

require 'rails_helper'

RSpec.describe 'site/home.html.erb', type: :view do
  include RSpecHtmlMatchers
  before { visit '/' }

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
end
