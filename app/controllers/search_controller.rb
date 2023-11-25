# frozen_string_literal: true

require 'google/apis/civicinfo_v2'

class SearchController < ApplicationController
  def search
    found_state = flash[:state_identifier] && flash[:fips_identifier]

    if flash[:region] && flash[:area_code]
      selected_state = State.find_by(symbol: flash[:region])
      targeted_county = selected_state ? County.find_by(state_id: selected_state.id, fips_code: flash[:area_code]) : nil
    else
      selected_state = nil
      targeted_county = nil
    end
    

    address = params[:address]
    service = Google::Apis::CivicinfoV2::CivicInfoService.new
    service.key = Rails.application.credentials[:GOOGLE_API_KEY]
    result = service.representative_info_by_address(address: address)
    @representatives = Representative.civic_api_to_representative_params(result)

    render 'representatives/search'
  end
end
