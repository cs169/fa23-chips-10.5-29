# frozen_string_literal: true

require 'google/apis/civicinfo_v2'

class SearchController < ApplicationController
  def search

    if flash[:state_symbol] && flash[:county_fips]
      state_symbol = flash[:state_symbol]
      county_fips = flash[:county_fips]
    
      @selected_state = State.find_by(symbol: state_symbol)
      @selected_county = County.find_by(state_id: @selected_state.id, fips_code: county_fips) if @selected_state.present?
    else
      @selected_state = @selected_county = nil
    end
    

    address = params[:address]
    service = Google::Apis::CivicinfoV2::CivicInfoService.new
    service.key = Rails.application.credentials[:GOOGLE_API_KEY]
    result = service.representative_info_by_address(address: address)
    @representatives = Representative.civic_api_to_representative_params(result)

    render 'representatives/search'
  end
end
