require 'rails_helper'

RSpec.describe 'Inviting other users' do
  before do
    user = FactoryBot.create(:user)
    user_2 = FactoryBot.create(:user)
    user_3 = FactoryBot.create(:user)

    visit root_url
    expect(current_path).to eq(root_path)
    find('#signin-link-1').click

    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password

    click_button 'Log in'
    find('#browse-events-link-1').click

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

  it 'An event creator can invite other users to his event' do
    visit event_path(Event.last)
    expect(current_path).to eq(event_path(Event.last.id))

    visit users_url, params: { attended_event_id: Event.last.id }
    expect(page).to have_text('Invitation List')
    # expect(page).to have_text('Send Invitation')

    # find('#btn-send-invitation').click
    # expect(page).to have_text('Invited')
  end
end
