Rails.application.routes.draw do

  # 顧客側devise
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者側devise
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  # 顧客側ルーティング
  scope module: :public do
    root to: 'homes#top'
    get '/about' => 'homes#about', as: 'about'
    resources :items, only: [:index, :show]
    resources :genres, only: [:show]
    resources :cart_items do
      collection do
        delete 'destroy_all'
      end
    end
    resources :cart_items, only: [:index, :update, :destroy, :create]
    post '/orders/confirm' => 'orders#confirm', as: 'order_confirm'
    get '/orders/complete' => 'orders#complete', as: 'order_complete'
    resources :orders, only: [:new, :index, :create, :show]
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
    resource :customer do
      get 'my_page' => 'customers#show', as: 'my_page'
      get 'information/edit' => 'customers#edit', as: 'information_edit'
      patch 'information' => 'customers#update', as: 'information'
      get 'unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
      patch 'withdraw' => 'customers#withdraw', as: 'withdraw'
    end
  end

  # 管理者側ルーティング
  namespace :admin do
    root "homes#top"
    resources :items, only: [:new, :create, :index, :show, :edit, :update]
    resources :genres, only: [:index, :edit, :update, :create]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:new, :show, :update]
    resources :order_details, only: [:update]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
