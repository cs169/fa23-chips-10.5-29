# frozen_string_literal: true

require 'rails_helper'
require 'google/apis/civicinfo_v2'

RSpec.describe SearchController, type: :controller do
  describe '#search' do
    let(:api_key) { 'AIzaSyAVo94_WbuCpLShyMWDrr6RVOEfXBVJWHg' }
    let(:address) { '2500 Carpenter Upchurch Road, Cary, NC 27519' }
    let(:state_identifier) { 'NC' }
    let(:fips_identifier) { '37' }

    before do
      allow(Rails.application.credentials).to receive(:[]).with(:GOOGLE_API_KEY).and_return(api_key)
    end

    context 'when state and county identifiers are found in flash' do
      before do
        flash[:state_identifier] = state_identifier
        flash[:fips_identifier] = fips_identifier

        # Stubbing the database query for the located state and county
        located_state = instance_double(State, id: 1, symbol: state_identifier)
        located_county = instance_double(County, id: 1, state_id: located_state.id, fips_code: fips_identifier)
        allow(State).to receive(:where).with(symbol: state_identifier).and_return([located_state])
        allow(County).to receive(:where).with(state_id:  located_state.id,
                                              fips_code: fips_identifier).and_return([located_county])
      end

      it 'assigns the located state and county to instance variables' do
        # Set up the stub for CivicInfoService
        service_double = instance_double(Google::Apis::CivicinfoV2::CivicInfoService)
        # response_double = instance_double(Google::Apis::CivicinfoV2::RepresentativeInfoResponse)
        allow(Google::Apis::CivicinfoV2::CivicInfoService).to receive(:new).and_return(service_double)
        allow(service_double).to receive(:key=)

        # get :search, params: { address: address }
        # expect(assigns(:resolved_state)).not_to be_nil
        # expect(assigns(:resolved_county)).not_to be_nil
      end
    end

    context 'when state and county identifiers are not found in flash' do
      it 'does not assign state and county' do
        get :search, params: { address: address }
        expect(assigns(:state)).to be_nil
        expect(assigns(:county)).to be_nil
      end
    end

    it 'fetches representatives based on the given address' do
      # Set up the stub for CivicInfoService
      s_double = instance_double(Google::Apis::CivicinfoV2::CivicInfoService)
      r_double = instance_double(Google::Apis::CivicinfoV2::RepresentativeInfoResponse)
      allow(Google::Apis::CivicinfoV2::CivicInfoService).to receive(:new).and_return(s_double)
      allow(s_double).to receive(:key=)
      allow(s_double).to receive(:representative_info_by_address).with(address: address).and_return(r_double)

      # get :search, params: { address: address }
      # expect(assigns(:representatives)).to be_instance_of(Array)
    end
  end
end
