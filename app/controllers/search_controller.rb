# frozen_string_literal: true

require 'google/apis/civicinfo_v2'

class SearchController < ApplicationController
  def search
    @selected_state, @selected_county = flash[:state] && flash[:county] ? 
  [State.find_by(symbol: flash[:state]), County.find_by(state: State.find_by(symbol: flash[:state]).id, fips_code: flash[:county])] : 
  [nil, nil]

    address = params[:address]
    service = Google::Apis::CivicinfoV2::CivicInfoService.new
    service.key = Rails.application.credentials[:GOOGLE_API_KEY]
    result = service.representative_info_by_address(address: address)
    @representatives = Representative.civic_api_to_representative_params(result)

    render 'representatives/search'
  end
end
