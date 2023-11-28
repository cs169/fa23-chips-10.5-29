# frozen_string_literal: true

require 'google/apis/civicinfo_v2'

class SearchController < ApplicationController
  def search
    if flash[:state] && flash[:county]
      @selected_state = State.find_by(symbol: flash[:state])
      @selected_county = County.find_by(
        state:     @selected_state.id,
        fips_code: flash[:county]
      )
    else
      @selected_state = nil
      @selected_county = nil
    end

    address = params[:address]
    service = Google::Apis::CivicinfoV2::CivicInfoService.new
    service.key = Rails.application.credentials[:GOOGLE_API_KEY]
    result = service.representative_info_by_address(address: address)
    @representatives = Representative.civic_api_to_representative_params(result)

    render 'representatives/search'
  end
end
