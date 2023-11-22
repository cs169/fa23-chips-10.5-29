# frozen_string_literal: true

# spec/requests/representatives_spec.rb

require 'rails_helper'
require 'spec_helper'
require 'google/apis/civicinfo_v2'

describe 'Representatives', type: :request do
  describe 'GET /representatives/:id' do
    before do
      address = '416 Charleville Court, Cary, NC 27519'
      service = Google::Apis::CivicinfoV2::CivicInfoService.new
      service.key = Rails.application.credentials[:GOOGLE_API_KEY]
      rep_info = service.representative_info_by_address(address: address)

      # Create a Representative instance for testing
      @representative = Representative.create!(name: rep_info.officials.first.name, title: rep_info.offices.first.name)
    end

    it 'displays the correct representative details' do
      get representative_path(@representative)

      expect(response).to have_http_status(:success)
      expect(response.body).to include(@representative.name)
      expect(response.body).to include(@representative.title)
      # Additional checks for other fields can be added here
    end
  end
end
