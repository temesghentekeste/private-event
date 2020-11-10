require 'rails_helper'

describe 'creating a new user' do
  it 'saves a user and signs in' do
    visit root_url
    find('#sign-up-btn-1').click

    expect(current_path).to eq(new_user_registration_path)
    fill_in 'user_name', with: 'John Doe'
    fill_in 'user_username', with: 'johndoe'
    fill_in 'user_email', with: 'johndoe@test.com'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    click_button 'Sign up'
    expect(current_path).to eq(root_path)

    expect(page).to have_text('Welcome to Private Event')
    expect(page).to have_text('John Doe')
    expect(page).to have_text('Create a new Event')
  end

  it 'does not save user if user parameters are invalid' do
    visit new_user_registration_path
    click_button 'Sign up'

    expect(page).to have_text("Name can't be blank")
    expect(page).to have_text("Username can't be blank")
    expect(page).to have_text("Email can't be blank")
    expect(page).to have_text("Password can't be blank")
  end
end
