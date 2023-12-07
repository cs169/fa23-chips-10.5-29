# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserController, type: :controller do
  describe 'GET #profile' do
    let(:user) do
      User.create!(
        provider: 1,
        uid:      0
      )
    end

    context 'when the user is logged in' do
      before do
        session[:current_user_id] = user.id
      end

      it 'assigns the user to @user' do
        get :profile

        expect(response).to have_http_status(:ok)
        expect(assigns(:user)).to eq(user)
      end
    end

    context 'when the user is not logged in' do
      it 'redirects to the login page' do
        get :profile

        expect(response).to redirect_to(login_path)
      end
    end
  end
end
