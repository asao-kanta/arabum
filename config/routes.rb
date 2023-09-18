Rails.application.routes.draw do
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
  root "girl#index"
  get "/urls", to: "urls#index"
  resources :urls
end
