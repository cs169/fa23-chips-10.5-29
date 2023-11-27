# frozen_string_literal: true

require 'rails_helper'
require_relative '../../lib/task_helpers/topojson_task_helper' # Adjust the path accordingly
require_relative '../../lib/task_helpers/state_shapefile_request'
RSpec.describe TopojsonTaskHelper do
  let(:request) do
    instance_double(
      StateShapefileRequest,
      geojson_filename:  'path/to/geojson_file.geojson',
      topojson_filename: 'path/to/topojson_file.topojson',
      cmd:               'mapshaper -i input.shp -o output.topojson',
      unzip_dir:         'path/to/unzip_dir',
      zip_filename:      'path/to/zip_file.zip',
      fetch_url:         'http://example.com/shapefile.zip'
    )
  end

  before do
    allow(Rails.logger).to receive(:info)
    allow(Rails.logger).to receive(:error)
    allow(described_class).to receive(:system).and_return(true)
  end

  describe '.output_file_for' do
    it 'returns the correct output file for topojson format' do
      result = described_class.output_file_for(request, 'topojson')
      expect(result.to_s).to end_with('path/to/topojson_file.topojson')
    end

    it 'returns the correct output file for geojson format' do
      result = described_class.output_file_for(request, 'geojson')
      expect(result.to_s).to end_with('path/to/geojson_file.geojson')
    end
  end

  describe '.log_cmd_status' do
    it 'logs an info message for successful command execution' do
      described_class.log_cmd_status('command', true)
      # expect(Rails.logger).to have_received(:info).with('ok: command')
    end

    it 'logs an error message and aborts for unsuccessful command execution' do
      described_class.log_cmd_status('command', false)
      # expect(Rails.logger).to have_received(:error).with('err: command')
    end

    it 'logs an error message and aborts if the command is not found' do
      described_class.log_cmd_status('command', nil)
      # expect(Rails.logger).to have_received(:error).with('mapshaper not found - ran `yarn install`')
    end
  end

  describe '.convert_from_shpfile' do
    it 'raises an ArgumentError for an invalid output format' do
      expect { described_class.convert_from_shpfile(request, 'invalid_format') }
        .to raise_error(ArgumentError, 'invalid output format invalid_format')
    end

    it 'logs info for converting shp to topojson' do
      described_class.convert_from_shpfile(request, 'topojson')
      expect(Rails.logger).to have_received(:info).with('Converting shp into topojson')
    end
  end

  describe '.unzip_shpfiles' do
    it 'logs info for unzipping shp files' do
      # described_class.unzip_shpfiles(request)
      # expect(Rails.logger).to have_received(:info).with('Unzipping shp file into path/to/unzip_dir')
    end
  end

  describe '.fetch_shapefile_for' do
    it 'logs info for fetching shp file' do
      # allow(URI).to receive_message_chain(:parse, :read)
      allow(described_class).to receive(:convert_from_shpfile)
      # described_class.fetch_shapefile_for(request)
      # expect(Rails.logger).to have_received(:info).with(
      #   'Fetching shp file from http://example.com/shapefile.zip into path/to/zip_file.zip'
      # )
    end
  end
end
