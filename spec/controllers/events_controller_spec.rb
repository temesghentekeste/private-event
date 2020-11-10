require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe 'GET #new' do
    it 'redirects to signin path upon not signed users event creation' do
      get :new

      expect(response).to redirect_to(new_user_session_path)
      expect(response).to have_http_status(302)
      expect(flash[:alert]).to be_present
    end
  end

  describe 'GET #index' do
    it 'renders events listing view' do
      get :index

      expect(response).to render_template('index')
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do
    context 'if user is not signed in' do
      context 'and has invalid params' do
        it 'when only event name is present, redirects to user sign in page' do
          post :create, params: { event: { event_name: 'Fake Event Name' } }
          expect(response).to redirect_to(new_user_session_path)
          expect(response).to have_http_status(302)
          expect(flash[:alert]).to be_present
        end
      end

      context 'and has valid params' do
        it 'redirects to user sign in page' do
          post :create, params: {
            event: {
              creator_id: 1,
              title: Faker::Lorem.sentence(word_count: 2),
              description: Faker::Lorem.sentence(word_count: 3),
              start_datetime: Date.today,
              end_datetime: Date.today + 4.weeks
            }
          }
          expect(response).to redirect_to(new_user_session_path)
          expect(response).to have_http_status(302)
          expect(flash[:alert]).to be_present
        end
      end
    end
  end

  context 'if user is signed in' do
    context 'and event has valid parameters' do
      it 'redirects to event listing page' do
        @user = FactoryBot.create(:user)
        sign_in(@user)
        post :create, params: {
          event: {
            creator_id: @user.id,
            title: Faker::Lorem.sentence(word_count: 2),
            description: Faker::Lorem.sentence(word_count: 3),
            start_datetime: Date.today,
            end_datetime: Date.today + 4.weeks
          }
        }
        expect(response).to redirect_to(events_path)
        expect(response).to have_http_status(302)
      end
    end
  end
end
