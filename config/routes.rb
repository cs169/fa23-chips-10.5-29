# frozen_string_literal: true

# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
    get '/login' => 'login#login', :as => :login
    get '/login/google', to: redirect('auth/google_oauth2'), as: :google_login
    get '/login/github', to: redirect('auth/github'), as: :github_login
    get '/auth/google_oauth2/callback', to: 'login#google_oauth2', as: :google_oauth2_callback
    get '/auth/github/callback', to: 'login#github', as: :github_callback
    get '/logout' => 'login#logout', :as => :logout
    get '/user/profile', to: 'user#profile', as: :user_profile
    get '/my_news_items/search', to: 'my_news_items#new_search', as: 'new_search_my_news_items'
    get '/my_news_items/search_articles', to: 'my_news_items#search_articles', as: 'search_articles_representatives'
    root to: 'map#index', as: 'root'
    get '/state/:state_symbol' => 'map#state', :as => :state_map
    get '/state/:state_symbol/county/:std_fips_code' => 'map#county', :as => :county

    get '/ajax/state/:state_symbol' => 'ajax#counties'

    # Routes for Events
    resources :events, only: %i[index show]
    get '/my_events/new' => 'my_events#new', :as => :new_my_event
    match '/my_events/new', to: 'my_events#create', via: [:post]
    get '/my_events/:id' => 'my_events#edit', :as => :edit_my_event
    match '/my_events/:id', to: 'my_events#update', via: %i[put patch]
    match '/my_events/:id', to: 'my_events#destroy', via: [:delete]
    resources :my_news_items
    post 'my_news_items/create_from_selection', to: 'my_news_items#create_from_selection', as: 'create_from_selection_representatives'

    # Routes for Representatives
    resources :representatives, only: [:index]
    resources :representatives do
        resources :news_items, only: %i[index show]
        get '/representatives/:representative_id/my_news_item/new' => 'my_news_items#new',
            :as                                                    => :new_my_news_item
        match '/representatives/:representative_id/my_news_item/new', to:  'my_news_items#create',
                                                                      via: [:post]
        get '/representatives/:representative_id/my_news_item/:id' => 'my_news_items#edit',
            :as                                                    => :edit_my_news_item
        match '/representatives/:representative_id/my_news_item/:id', to:  'my_news_items#update',
                                                                      via: %i[put patch]
        match '/representatives/:representative_id/my_news_item/:id', to:  'my_news_items#destroy',
                                                                      via: [:delete]
        get '/representatives/search_articles', to: 'my_news_items#search_articles', as: 'search_articles_representatives'

        post 'my_news_items/create_from_selection', to: 'my_news_items#create_from_selection', as: 'create_from_selection_representatives'
                                                                    end

    get '/search/(:address)' => 'search#search', :as => 'search_representatives'
end
