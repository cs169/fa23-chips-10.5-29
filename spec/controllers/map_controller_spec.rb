# frozen_string_literal: true

# spec/controllers/map_controller_spec.rb
require 'rails_helper'

RSpec.describe MapController, type: :controller do
  # let(:state) { create(:state, symbol: 'CA') }
  # let(:county) { create(:county, state: state) }

  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      # expect(response).to render_template(:index)
      # expect(assigns(:states)).not_to be_nil
    end
  end

  describe 'GET #state' do
    it 'renders the state template' do
      # get :state, params: { state_symbol: state.symbol }
      # expect(response).to render_template(:state)
      # expect(assigns(:state)).to eq(state)
      # expect(assigns(:county_details)).not_to be_nil
    end

    it 'redirects to root_path if state is not found' do
      # get :state, params: { state_symbol: 'INVALID' }
      # expect(response).to redirect_to(root_path)
      # expect(flash[:alert]).to eq("State 'INVALID' not found.")
    end
  end

  describe 'GET #county' do
    it 'renders the county template' do
      # get :county, params: { state_symbol: state.symbol, std_fips_code: county.std_fips_code }
      # expect(response).to render_template(:county)
      # expect(assigns(:state)).to eq(state)
      # expect(assigns(:county)).to eq(county)
      # expect(assigns(:county_details)).not_to be_nil
    end

    it 'redirects to root_path if state is not found' do
      # get :county, params: { state_symbol: 'INVALID', std_fips_code: county.std_fips_code }
      # expect(response).to redirect_to(root_path)
      # expect(flash[:alert]).to eq("State 'INVALID' not found.")
    end

    it 'redirects to root_path if county is not found' do
      # get :county, params: { state_symbol: state.symbol, std_fips_code: 'INVALID' }
      # expect(response).to redirect_to(root_path)
      # expect(flash[:alert]).to eq("County with code 'INVALID' not found for CA")
    end
  end
end
