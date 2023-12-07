# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  before do
    @state = instance_double(State, id: 1, symbol: 'NC')
    @county = instance_double(County, id: 1, state_id: @state.id, fips_code: 1)
    @event = instance_double(Event, id: 1, county_id: @county.id)
  end
  # let(:state) { instance_double(State, id: 1, symbol: 'NC')}
  # let(:county) { instance_double(County, id: 1, state_id: @state.id, fips_code: 1) }
  # let(:event) { instance_double(Event, id: 1, county_id: county.id) }

  describe 'GET #index' do
    context 'without filter' do
      it 'assigns @events and renders the index template' do
        get :index
        expect(assigns(:events)).to eq(Event.all)
        expect(response).to render_template('index')
      end
    end

    context 'with state-only filter' do
      it 'assigns @events filtered by state and renders the index template' do
        # get :index, params: { 'filter-by' => 'state-only', 'state' => @state.symbol }
        # expect(assigns(:events)).to eq(Event.where(county: @county))
        # expect(response).to render_template('index')
      end
    end

    context 'with county filter' do
      it 'assigns @events filtered by county and renders the index template' do
        # get :index, params: { 'filter-by' => 'county', 'state' => @state.symbol, 'county' => @county.fips_code }
        # expect(assigns(:events)).to eq(Event.where(county: @county))
        # expect(response).to render_template('index')
      end
    end
  end

  describe 'GET #show' do
    it 'assigns @event and renders the show template' do
      # get :show, params: { id: @event.id }
      # expect(assigns(:event)).to eq(@event)
      # expect(response).to render_template('show')
    end
  end
end
