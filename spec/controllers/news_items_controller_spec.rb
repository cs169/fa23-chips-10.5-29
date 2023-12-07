# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NewsItemsController, type: :controller do
  let(:representative) do
    Representative.create!(
      name:      '',
      title:     'Representative',
      street:    '2500 Carpenter Upchurch Road, Cary, NC 27519',
      photo_url: 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/A_black_image.jpg/640px-A_black_image.jpg'
    )
  end
  let(:news_item) do
    NewsItem.create!(
      title:             'New York Times',
      description:       'whatever',
      representative:    representative,
      issue:             'Immigration',
      representative_id: representative.id,
      link:              'www.newyorktimes.com'
    )
  end

  describe 'GET #index' do
    it 'assigns @news_items and renders the index template' do
      get :index, params: { representative_id: representative.id }
      expect(assigns(:news_items)).to eq([news_item])
      expect(response).to render_template('index')
    end
  end

  describe 'GET #show' do
    it 'assigns @news_item and renders the show template' do
      get :show, params: { representative_id: representative.id, id: news_item.id }
      expect(assigns(:news_item)).to eq(news_item)
      expect(assigns(:news_items)).to eq([news_item])
      expect(response).to render_template('show')
    end
  end
end
