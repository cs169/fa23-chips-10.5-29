# frozen_string_literal: true

require 'google/apis/civicinfo_v2'

class SearchController < ApplicationController
  def search

    found_state = flash[:state_identifier] && flash[:fips_identifier]

    if found_state
      state_key = flash[:state_identifier]
      fips_key = flash[:fips_identifier]

      located_state = State.where(symbol: state_key).first
      located_county = County.where(state_id: located_state.try(:id), fips_code: fips_key).first if located_state
      @resolved_state = located_state
      @resolved_county = located_county
  else
    @resolved_state = nil
    @resolved_county = nil
  end

    address = params[:address]
    service = Google::Apis::CivicinfoV2::CivicInfoService.new
    service.key = Rails.application.credentials[:GOOGLE_API_KEY]
    result = service.representative_info_by_address(address: address)
    @representatives = Representative.civic_api_to_representative_params(result)

    render 'representatives/search'
  end
end
