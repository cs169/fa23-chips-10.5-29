# frozen_string_literal: true

require 'httparty'

class MyNewsItemsController < SessionController
  before_action :set_representative, except: %i[new_search search_articles]
  before_action :set_news_item, only: %i[edit update destroy]
  before_action :ensure_articles_present, only: :create_from_selection

  def new
    @news_item = NewsItem.new
  end

  def edit; end

  def create
    @news_item = NewsItem.new(news_item_params)
    handle_save(@news_item, :new)
  end

  def update
    handle_save(@news_item, :edit)
  end

  def create_from_selection
    article = fetch_selected_article
    @news_item = build_news_item(article)

    if save_news_item
      redirect_to_success('News item was successfully created from the selected article.',
                          representative_news_item_path(params[:representative_id], @news_item))
    else
      render_failure
    end
  end

  def destroy
    @news_item.destroy
    redirect_to_success('News was successfully destroyed.', representative_news_items_path(@representative))
  end

  def new_search
    # Renders the form for selecting a representative and an issue
    render :new_search
  end

  def search_articles
    @articles = ArticleSearcher.new(params[:representative_id], params[:issue]).fetch_top_articles

    if @articles.empty?
      flash[:notice] = 'No articles found for the given criteria.'
      redirect_to new_search_my_news_items_path
    else
      render :search_results
    end
  end

  private

  def handle_save(news_item, action)
    if news_item.save
      redirect_to_success('News item was successfully created.', representative_news_item_path(@representative, news_item))
    else
      flash.now[:error] = "An error occurred when #{action == :new ? 'creating' : 'updating'} the news item."
      render action
    end
  end

  def ensure_articles_present
    return unless session[:articles].nil?

    flash[:error] = 'Session expired or invalid. Please try again.'
    redirect_to new_search_my_news_items_path and return
  end

  def redirect_to_success(message, path)
    redirect_to path, notice: message
  end

  def render_failure
    flash.now[:error] = 'An error occurred when creating the news item.'
    render :new_search
  end

  def fetch_selected_article
    selected_index = params[:selected_article].to_i
    session[:articles][selected_index]
  end

  def build_news_item(article)
    NewsItem.new(
      title:             article['title'],
      description:       article['description'],
      link:              article['url'],
      issue:             params[:issue],
      representative_id: params[:representative_id]
    )
  end

  def save_news_item
    @news_item.save
  end

  def set_representative
    @representative = Representative.find(params[:representative_id])
  end

  def set_news_item
    @news_item = NewsItem.find(params[:id])
  end

  def news_item_params
    params.require(:news_item).permit(:title, :description, :link, :issue, :representative_id)
  end
end

class ArticleSearcher
  include HTTParty
  base_uri 'https://newsapi.org/v2'

  def initialize(representative_id, issue)
    @query = build_query(representative_id, issue)
  end

  def fetch_top_articles
    self.class.get('/everything', query: query_params).parsed_response['articles']
  end

  private

  def build_query(representative_id, issue)
    representative = Representative.find(representative_id).name
    "#{representative}+#{issue}".gsub(/\s/, '')
  end

  def query_params
    {
      apiKey:   '517fca8560464c6794684840982007a1',
      q:        @query,
      pageSize: 5
    }
  end
end
