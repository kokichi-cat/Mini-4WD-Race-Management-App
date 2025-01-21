Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks",
    passwords: "users/passwords" # パスワードリセットのため
  }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
  root "top#top" # 仮トップページ
  get "top/top"
  resources :events, only: %i[index new create show edit update destroy] do # 掲示板の一覧表示と新規作成画面への設定
    collection do
      get "user_index" # ログインユーザー専用のレース一覧ページ
    end
  end

  get "terms", to: "static_pages#terms", as: :terms
  get "privacy", to: "static_pages#privacy", as: :privacy
  # get "contact", to: "static_pages#contact", as: :contact　独自の回答フォームを作成したくなったらコメントアウト外す
  get "mypage", to: "users#mypage", as: :mypage
end
