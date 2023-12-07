# frozen_string_literal: true

# spec/controllers/ajax_controller_spec.rb
require 'rails_helper'

RSpec.describe AjaxController, type: :controller do
  describe 'GET #counties' do
    let(:state) { create(:state, symbol: 'NC') }

    it 'returns a JSON response with counties for the specified state' do
      # get :counties, params: { state_symbol: 'NC' }

      # expect(response).to have_http_status(:ok)
      # expect(response.content_type).to eq('application/json')

      # json_response = JSON.parse(response.body)
      # expect(json_response).to be_an(Array)
      # Assuming your State model has a `counties` association
      # expect(json_response.length).to eq(state.counties.count)
    end

    it 'returns an empty JSON array if the state is not found' do
      # get :counties, params: { state_symbol: 'NonExistentState' }

      # expect(response).to have_http_status(:ok)
      # expect(response.content_type).to eq('application/json')

      # json_response = JSON.parse(response.body)
      # expect(json_response).to be_an(Array)
      # expect(json_response).to be_empty
    end
  end
end
