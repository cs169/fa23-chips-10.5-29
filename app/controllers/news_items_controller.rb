# frozen_string_literal: true

class NewsItemsController < ApplicationController
  before_action :set_representative
  before_action :set_news_item, only: %i[show]

  def index
    @news_items = @representative.news_items
  end

  def show
    # Assuming @news_item is set for individual item
    @news_item = NewsItem.find(params[:id])
    # Ensure that @news_items is set for the collection if needed
    @news_items = NewsItem.where(representative_id: @news_item.representative_id)
  end

  private

  def search_articles
    # Fetch the articles from the News API based on the selected representative and issue
    # This requires you to create a service object or a method to interact with the News API
    @articles = NewsApiService.new(params[:representative_id], params[:issue]).fetch_articles
    if @articles.blank?
      redirect_to new_search_representatives_path, alert: 'No articles found. Please try again.'
    else
      render :search_results # This will be a new view you need to create
    end
  end

  def set_representative
    @representative = Representative.find(
      params[:representative_id]
    )
  end

  def set_news_item
    @news_item = NewsItem.find(params[:id])
  end
end
