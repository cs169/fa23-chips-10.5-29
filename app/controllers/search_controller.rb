# frozen_string_literal: true

require 'google/apis/civicinfo_v2'

class SearchController < ApplicationController
  def search
    if flash[:state] && flash[:county]
      @state = State.find_by(symbol: flash[:state])
      @county = County.find_by(state_id: @state.id, fips_code: flash[:county]) if @state
    end
    if flash[:state_identifier] && flash[:fips_identifier]
      located_state = State.find_by(symbol: flash[:state_identifier])
      @resolved_state = located_state
      @resolved_county = located_state ? County.find_by(state_id: located_state.id, fips_code: flash[:fips_identifier]) : nil
    else
      @resolved_state = @resolved_county = nil
    end    

    address = params[:address]
    service = Google::Apis::CivicinfoV2::CivicInfoService.new
    service.key = Rails.application.credentials[:GOOGLE_API_KEY]
    result = service.representative_info_by_address(address: address)
    @representatives = Representative.civic_api_to_representative_params(result)

    render 'representatives/search'
  end
end
