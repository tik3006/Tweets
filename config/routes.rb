Rails.application.routes.draw do
  #トップページへのルーティング
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  
  #registractionに設定
  get 'registration', to: 'users#new'
  #今のところUseの削除とユーザー名編集を考えていないのでこのルーティングとする
  resources :users, only: [:index, :show, :create]
end
