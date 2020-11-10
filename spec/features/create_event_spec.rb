require 'rails_helper'

describe 'Creating a new event' do
  before do
    visit root_url
    find('#sign-up-btn-1').click

    expect(current_path).to eq(new_user_registration_path)
    fill_in 'user_name', with: 'John Doe'
    fill_in 'user_username', with: 'johndoe'
    fill_in 'user_email', with: 'johndoe@test.com'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    click_button 'Sign up'
  end

  it 'creates a new event only if a user is signed in' do
    visit root_url

    find('#create-new-event-btn-1').click

    expect(current_path).to eq(new_event_path)

    fill_in 'event_title', with: 'JS Virtual Event'
    fill_in 'event_description', with: 'Code and Fun Event'
    select (Time.now.year + 1).to_s, from: 'event_start_datetime_1i'
    select (Time.now.year + 2).to_s, from: 'event_end_datetime_1i'

    click_button 'Create Event'

    expect(current_path).to eq(events_path)
    expect(page).to have_text('Upcoming Events')
    expect(page).to have_text('Past Events')
  end

  describe 'creating an Event when user not signed in' do
    it 'creating a new event requires a user to sign in or sign up' do
      find('#logout-link-1').click

      expect(page).to have_link('Sign Up')
      expect(page).to have_link('Sign In')
      expect(page).to have_link('Browse Events')
      expect(page).to have_no_link('Create a new Event')
      expect(page).to have_no_link('All Events')
      expect(page).to have_no_link('Logout')
    end
  end
end
