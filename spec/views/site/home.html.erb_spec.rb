# frozen_string_literal:true

require 'rails_helper'

RSpec.describe 'site/new.html.erb', type: :view do
  include RSpecHtmlMatchers
  before { visit '/home' }

  it 'should have welcome h1' do
    expect(page).to have_content('WELCOME TO MINESWEEPER')
  end

  it 'should have a welcome image' do
    expect(page).to have_tag('img')
  end

  it 'should have a form' do
    expect(page).to have_tag('form')
  end

  it 'should have a form that has a row size field' do
    expect(page).to have_field('row_size')
  end

  it 'should have a form that has a bomb count field' do
    expect(page).to have_field('bomb_count')
  end
  
end
