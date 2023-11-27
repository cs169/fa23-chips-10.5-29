# frozen_string_literal: true

require 'google/apis/civicinfo_v2'

class SearchController < ApplicationController
  def search
    region_info, district_info = flash.values_at(:region, :district)

    if region_info && district_info
      region_record = State.where(symbol: region_info).first
      district_record = County.find_by(
        state_ref: region_record.try(:id), 
        district_code: district_info
      )
    else
      region_record = district_record = nil
  end

    address = params[:address]
    service = Google::Apis::CivicinfoV2::CivicInfoService.new
    service.key = Rails.application.credentials[:GOOGLE_API_KEY]
    result = service.representative_info_by_address(address: address)
    @representatives = Representative.civic_api_to_representative_params(result)

    render 'representatives/search'
  end
end
