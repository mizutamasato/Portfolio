Rails.application.routes.draw do

  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
}
 #ゲストログイン用
  devise_scope :public do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  
 # user側ルーティング
  scope module: 'public' do
    root 'homes#top'
    resources :reviews, only: [:new, :create, :edit, :serch,:index, :show, :destroy]do
      resources :comments, only: [:create, :destroy]  #reviewsに対してcomments子となるためネストする
    end

    get 'users/my_page' => 'users#show'
    patch 'users/update' => 'users#update'
    get 'users/edit' => 'users#edit'
    get '/users/unsubscribe' => 'users#unsubscribe' # 退会確認画面
    patch 'users/withdrawal' => 'users#withdrawal' # 退会の論理削除
    get "search_review" => "reviews#search_review"
  end

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  # admin側ルーティング
  namespace :admin do
    get 'admin' => 'admin#top'
    resources :users, only: [:index, :edit, :update, :show]
    resources :tags, only: [:index, :create, :edit, :update]
    resources :reviews, only: [:show, :index, :new, :create, :edit, :update, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
