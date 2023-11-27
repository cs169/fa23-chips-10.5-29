# frozen_string_literal: true

require 'rails_helper'
require_relative '../../lib/task_helpers/state_fips_task_helper'

describe StateFipsTaskHelper do
  before do
    @county_array = [
      { name: 'County A', fips_code: '001', fips_class: 'H1' },
      { name: 'County B', fips_code: '002', fips_class: 'H2' }
    ]
  end

  describe '.fips_csv_to_hash' do
    it 'converts FIPS CSV data to a hash' do
      csv_data = "CA,06,001,County A,H1\n" \
                 "CA,06,002,County B,H2\n"
      result = described_class.fips_csv_to_hash(csv_data)
      expect(result[0]).to eq({ name: 'County A', fips_code: '001', fips_class: 'H1' })
      expect(result[1]).to eq({ name: 'County B', fips_code: '002', fips_class: 'H2' })
    end
  end

  describe '.update' do
    it 'replaces county data in the array' do
      to_replace = { fips_code: '001', name: 'County A', fips_class: 'H1' }
      replacement = { fips_code: '003', name: 'County C', fips_class: 'H3' }

      result = described_class.update(@county_array, to_replace, replacement)

      expect(result[0]).to eq(replacement)
      expect(result[1]).to eq({ name: 'County B', fips_code: '002', fips_class: 'H2' })
    end
  end

  describe '.alaska_update' do
    it 'applies the Alaska county update' do
      ak_counties = [{ name: 'Wade Hampton Census Area', fips_code: '270', fips_class: 'H5' }]

      result = described_class.alaska_update(ak_counties)

      expect(result.length).to eq(1)
      expect(result[0]).to eq({ name: 'Kusilvak Census Area', fips_code: '158', fips_class: 'H5' })
    end
  end

  describe '.south_dakota_update' do
    it 'applies the South Dakota county update' do
      sd_counties = [{ name: 'Shannon County', fips_code: '113', fips_class: 'H1' }]

      result = described_class.south_dakota_update(sd_counties)

      expect(result.length).to eq(1)
      expect(result[0]).to eq({ name: 'Oglala Lakota County', fips_code: '102', fips_class: 'H1' })
    end
  end

  describe '.virginia_update' do
    it 'applies the Virginia county update' do
      va_counties = [{ name: 'Bedford City', fips_code: '515', fips_class: 'C7' }]

      result = described_class.virginia_update(va_counties)

      expect(result.length).to eq(0)
    end
  end
end
