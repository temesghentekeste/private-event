require 'rails_helper'

describe 'WelcomeToPrivateEvent', type: :feature do
  before do
    visit root_url
  end
  context 'Welcome to Private Event' do
    it 'should have Welcome to Private Event' do
      visit root_url
      expect(page).to have_content('Welcome to Private Event')
    end
  end
end
