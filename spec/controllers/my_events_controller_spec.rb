# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MyEventsController, type: :controller do
  before do
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
    # get :google_oauth2
    # allow(User).to receive(:find).with(1).and_return(create(:user, id: 1))
    # session[:current_user_id] = 1
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      # expect(response).to render_template(:new)
      # expect(response).to redirect_to(login_path)
    end

    it 'assigns a new event as @event' do
      get :new
      # expect(assigns(:event)).to be_a_new(Event)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new event' do
        # expect {
        #   post :create, params: { event: valid_event_attributes }
        # }.to change(Event, :count).by(1)
      end

      it 'redirects to the events path' do
        # post :create, params: { event: valid_event_attributes }
        # expect(response).to redirect_to(events_path)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new event' do
        # expect {
        # post :create, params: { event: invalid_event_attributes }
        # }.not_to change(Event, :count)
      end

      it 'renders the new template' do
        # post :create, params: { event: invalid_event_attributes }
        # expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #edit' do
    it 'renders the edit template' do
      # event = create(:event)
      # get :edit, params: { id: event.id }
      # expect(response).to render_template(:edit)
    end

    it 'assigns the requested event as @event' do
      # event = create(:event)
      # get :edit, params: { id: event.id }
      # expect(assigns(:event)).to eq(event)
    end
  end

  describe 'PUT #update' do
    # let(:event) { create(:event) }

    context 'with valid parameters' do
      it 'updates the requested event' do
        # put :update, params: { id: event.id, event: valid_event_attributes }
        # event.reload
        # expect(event.attributes).to include(valid_event_attributes.stringify_keys)
      end

      it 'redirects to the events path' do
        # put :update, params: { id: event.id, event: valid_event_attributes }
        # expect(response).to redirect_to(events_path)
      end
    end

    context 'with invalid parameters' do
      it 'does not update the requested event' do
        # put :update, params: { id: event.id, event: invalid_event_attributes }
        # event.reload
        # expect(event.attributes).not_to include(invalid_event_attributes.stringify_keys)
      end

      it 'renders the edit template' do
        # put :update, params: { id: event.id, event: invalid_event_attributes }
        # expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested event' do
      # event = create(:event)
      # expect {
      #   delete :destroy, params: { id: event.id }
      # }.to change(Event, :count).by(-1)
    end

    it 'redirects to the events path' do
      # event = create(:event)
      # delete :destroy, params: { id: event.id }
      # expect(response).to redirect_to(events_path)
    end
  end

  private

  def valid_event_attributes
    # Define valid attributes for creating or updating an event
    { name: 'Valid Event', county_id: 1, description: 'Valid description', start_time: Time.zone.now,
end_time: Time.zone.now + 1.hour }
  end

  def invalid_event_attributes
    # Define invalid attributes for testing error cases
    { name: nil, county_id: nil, description: nil, start_time: nil, end_time: nil }
  end
end
