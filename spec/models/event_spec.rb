# frozen_string_literal: true

# spec/models/event_spec.rb
require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:county) { create(:county) }

  it { is_expected.to belong_to(:county) }
  it { is_expected.to validate_presence_of(:start_time) }
  it { is_expected.to validate_presence_of(:end_time) }

  it do
    # should validate_numericality_of(:start_time)
    # .is_greater_than_or_equal_to(Time.zone.now.to_i)
    # .with_message('must be after today')
  end

  it do
    # should validate_date_of(:end_time)
    #   .is_after_or_equal_to(:start_time)
    #   .with_message('must be after start time')
  end

  describe '#county_names_by_id' do
    context 'when the event has a county with a state' do
      # let(:event) { create(:event, county: county) }

      it 'returns a hash of county names by id' do
        # expect(event.county_names_by_id).to eq({ county.name => county.id })
      end
    end

    context 'when the event has no county' do
      # let(:event) { build(:event, county: nil) }

      it 'returns an empty hash' do
        # expect(event.county_names_by_id).to eq({})
      end
    end
  end
end
