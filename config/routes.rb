# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      scope :auth do
        post '/login' => 'auth#login'
        post '/logout' => 'auth#logout'
      end

      scope :users do
        post '/' => 'users#signup'

        scope ':user_id' do
          delete '/' => 'users#delete'
        end
      end

      scope :products do
        get '/' => 'products#index'
        post '/' => 'products#create'

        scope ':product_id' do
          put '/' => 'products#update'
          delete '/' => 'products#delete'
          post '/' => 'products#buy'
        end
      end

      scope :wallets do
        post '/deposit' => 'wallet#deposit'
        post '/reset' => 'wallet#reset'
      end
    end
  end
end
