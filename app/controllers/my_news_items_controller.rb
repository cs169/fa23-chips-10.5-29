# frozen_string_literal: true
require 'httparty'
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
  def create_from_selection
    # Ensure that the articles are present in the session
    if session[:articles].nil?
      flash[:error] = 'Session expired or invalid. Please try again.'
      redirect_to new_search_my_news_items_path and return
    end

    # Get the selected article index and retrieve the article from the session
    selected_index = params[:selected_article].to_i
    article = session[:articles][selected_index]

    # Create a new news item with the selected article details
    @news_item = NewsItem.new(
      title: article['title'],
      description: article['description'],
      link: article['url'],
      issue: params[:issue],
      representative_id: params[:representative_id]
    )
    
    if @news_item.save
      redirect_to representative_news_item_path(params[:representative_id], @news_item),
                  notice: 'News item was successfully created from the selected article.'
    else
      flash.now[:error] = 'An error occurred when creating the news item.'
      render :new_search
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
    query = build_query(params[:representative_id], params[:issue])
    @articles = fetch_top_articles(query)
    
    if @articles.empty?
      flash[:notice] = 'No articles found for the given criteria.'
      redirect_to new_search_my_news_items_path
    else
      render :search_results # Ensure you have a search_results.html.haml view
    end
  end
  
  # Helper method to build query string from representative and issue
  def build_query(representative_id, issue)
    representative = Representative.find(representative_id).name
    # Combine representative's name and issue, replacing spaces with '+'
    "#{representative}+#{issue}".gsub(/\s/, "")
  end
  
  # Helper method to fetch top 5 articles from the News API
  def fetch_top_articles(query)
    url = 'https://newsapi.org/v2/everything'
  
    response = HTTParty.get(url, {
      query: {
        apiKey: '517fca8560464c6794684840982007a1',
        q: query,
        pageSize: 5 # Limit to 5 articles
      }
    })
    return response.parsed_response['articles']
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
