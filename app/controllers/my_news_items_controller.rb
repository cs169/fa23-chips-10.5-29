# frozen_string_literal: true

class MyNewsItemsController < SessionController
  before_action :set_representative, except: %i[new_search search_articles]
  before_action :set_news_item, only: %i[edit update destroy]

  def new
    @news_item = NewsItem.new
  end

  def edit; end

  def create
    @news_item = NewsItem.new(news_item_params)
    if @news_item.save
      redirect_to representative_news_item_path(@representative, @news_item),
                  notice: 'News item was successfully created.'
    else
      flash.now[:error] = 'An error occurred when creating the news item.'
      render :new
    end
  end

  def update
    if @news_item.update(news_item_params)
      redirect_to representative_news_item_path(@representative, @news_item),
                  notice: 'News item was successfully updated.'
    else
      flash.now[:error] = 'An error occurred when updating the news item.'
      render :edit
    end
  end

  def destroy
    @news_item.destroy
    redirect_to representative_news_items_path(@representative),
                notice: 'News was successfully destroyed.'
  end

  def new_search
    # Renders the form for selecting a representative and an issue
    # Ensure the form submits to the search_articles action
    render :new_search
  end

  def search_articles
    @articles = NewsApiService.new(params[:representative_id], params[:issue]).fetch_articles
    if @articles.blank?
      redirect_to new_search_my_news_items_path, alert: 'No articles found. Please try again.'
    else
      render :search_results
    end
  end

  private

  def set_representative
    @representative = Representative.find(params[:representative_id])
  end

  def set_representatives_list
    @representatives_list = Representative.all.map { |r| [r.name, r.id] }
  end

  def set_news_item
    @news_item = NewsItem.find(params[:id])
  end

  def news_item_params
    params.require(:news_item).permit(:title, :description, :link, :issue, :representative_id)
  end
end
