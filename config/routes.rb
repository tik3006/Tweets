Rails.application.routes.draw do
  #トップページへのルーティング
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  
  #registractionに設定
  get 'registration', to: 'users#new'
  
  #今のところUserの削除とユーザー名編集を考えていないのでこのルーティングとする
  resources :users, only: [:index, :show, :create] do
    member do
      get :followings
      get :followers
      get :likes
    end
  end
  
  resources :posts, only: [:create, :destroy, :edit, :update]
  resources :follows, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
end
