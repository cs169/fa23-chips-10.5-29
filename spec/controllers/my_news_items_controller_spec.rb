# frozen_string_literal: true

# spec/controllers/my_news_items_controller_spec.rb
require 'rails_helper'

RSpec.describe MyNewsItemsController, type: :controller do
  before do
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
    # get :google_oauth2
  end

  # let(:representative) { create(:representative) } # Assuming you have FactoryBot for creating test data

  describe 'GET #new' do
    it 'renders the new template' do
      # allow(controller).to receive(:already_logged_in)
      # get :new, params: { representative_id: representative.id }
      # expect(response).to render_template('new')
      # expect(assigns(:news_item)).to be_a_new(NewsItem)
    end
  end

  describe 'GET #edit' do
    # let(:news_item) { create(:news_item, representative: representative) }

    it 'renders the edit template' do
      # get :edit, params: { representative_id: representative.id, id: news_item.id }
      # expect(response).to render_template('edit')
      # expect(assigns(:news_item)).to eq(news_item)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new news item' do
        # news_item_params = attributes_for(:news_item, representative_id: representative.id)

        # expect {
        #   post :create, params: { representative_id: representative.id, news_item: news_item_params }
        # }.to change(NewsItem, :count).by(1)

        # expect(response).to redirect_to(representative_news_item_path(representative, assigns(:news_item)))
        # expect(flash[:notice]).to eq('News item was successfully created.')
      end
    end

    context 'with invalid parameters' do
      it 'renders the new template' do
        # post :create, params: { representative_id: representative.id, news_item: { title: 'Invalid News Item' } }

        # expect(response).to render_template('new')
        # expect(flash[:error]).to eq('An error occurred when creating the news item.')
      end
    end
  end

  describe 'PATCH #update' do
    # let(:news_item) { create(:news_item, representative: representative) }

    context 'with valid parameters' do
      it 'updates the news item' do
        # patch :update, params:
        #       { representative_id: representative.id, id: news_item.id, news_item: { title: 'Updated Title' } }
        # news_item.reload

        # expect(response).to redirect_to(representative_news_item_path(representative, news_item))
        # expect(flash[:notice]).to eq('News item was successfully updated.')
        # expect(news_item.title).to eq('Updated Title')
      end
    end

    context 'with invalid parameters' do
      it 'renders the edit template' do
        #   patch :update, params: { representative_id: representative.id, id: news_item.id, news_item: { title: '' } }

        # expect(response).to render_template('edit')
        # expect(flash[:error]).to eq('An error occurred when updating the news item.')
      end
    end
  end

  describe 'DELETE #destroy' do
    # let!(:news_item) { create(:news_item, representative: representative) }

    it 'destroys the news item' do
      # expect {
      #   delete :destroy, params: { representative_id: representative.id, id: news_item.id }
      # }.to change(NewsItem, :count).by(-1)

      # expect(response).to redirect_to(representative_news_items_path(representative))
      # expect(flash[:notice]).to eq('News was successfully destroyed.')
    end
  end
end
