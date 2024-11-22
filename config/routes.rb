Rails.application.routes.draw do

  get "up" => "rails/health#show", as: :rails_health_check

  root to: "lists#index"
  resources :lists, only: [:show, :new, :create] do
    resources :bookmarks, only: [:new, :create, :destroy]
  end
end
