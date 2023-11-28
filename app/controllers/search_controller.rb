# frozen_string_literal: true

require 'google/apis/civicinfo_v2'

class SearchController < ApplicationController
  def search
    # Return nil for both @state and @county if flash[:state] or flash[:county] are not present
    return @state, @county = nil unless flash[:state] && flash[:county]

    # Find the state and county when flash[:state] and flash[:county] are present
    @state = State.find_by(symbol: flash[:state])
    @county = County.find_by(state: @state.id, fips_code: flash[:county])

    address = params[:address]
    service = Google::Apis::CivicinfoV2::CivicInfoService.new
    service.key = Rails.application.credentials[:GOOGLE_API_KEY]
    result = service.representative_info_by_address(address: address)
    @representatives = Representative.civic_api_to_representative_params(result)

    render 'representatives/search'
  end
end
