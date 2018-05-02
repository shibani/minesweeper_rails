# frozen_string_literal:true

require 'rails_helper'

RSpec.describe 'site/gameover.html.erb', type: :view do
  before { visit '/gameover' }

  it 'should have selector h3' do
    expect(page).to have_content('Game over! You lose.')
  end
end
