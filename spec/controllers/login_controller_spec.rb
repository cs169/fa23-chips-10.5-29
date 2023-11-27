# frozen_string_literal: true

# spec/controllers/login_controller_spec.rb
require 'rails_helper'

RSpec.describe LoginController, type: :controller do
  before do
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
  end

  describe '#login' do
    it 'renders the login template' do
      get :login
      expect(response).to render_template('login')
    end
  end

  describe '#google_oauth2' do
    it 'creates a session for Google authentication' do
      get :google_oauth2
      expect(response).to redirect_to(root_url)
      expect(session[:current_user_id]).not_to be_nil
    end
  end

  describe '#github' do
    before do
      Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
    end

    it 'creates a session for GitHub authentication' do
      get :github
      expect(response).to redirect_to(root_url)
      expect(session[:current_user_id]).not_to be_nil
    end
  end

  describe '#logout' do
    it 'logs out the user' do
      session[:current_user_id] = 1
      get :logout
      expect(response).to redirect_to(root_path)
      expect(session[:current_user_id]).to be_nil
      expect(flash[:notice]).to eq('You have successfully logged out.')
    end
  end

  describe '#already_logged_in' do
    it 'redirects to user profile if user is already logged in' do
      session[:current_user_id] = 1
      get :login
      expect(response).to redirect_to(user_profile_path)
      expect(flash[:notice]).to eq('You are already logged in. Logout to switch accounts.')
    end

    it 'renders the login template if user is not logged in' do
      get :login
      expect(response).to render_template('login')
    end
  end
end
