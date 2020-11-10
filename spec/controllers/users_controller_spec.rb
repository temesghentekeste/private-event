RSpec.describe UsersController, type: :controller do
  describe 'GET #index' do
    it 'renders events listing view' do
      @user = FactoryBot.create(:user)
      @event = FactoryBot.create(:event)

      get :index, params: { attended_event_id: @event.id }

      expect(response).to render_template(nil)
      expect(response).to have_http_status(302)
    end
  end

  describe 'GET #show' do
    it 'renders the user show page' do
      @user = FactoryBot.create(:user)
      sign_in(@user)
      get :show, params: { id: @user.id }

      expect(response).to render_template('show')
      expect(response).to have_http_status(200)
    end
  end
end
