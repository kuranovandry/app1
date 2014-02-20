App1::Application.routes.draw do

  get "auto_complate/index"

  get "answers/index"

  get "questions/index"

get "autologin/login"

get "log_out" => "sessions#destroy", :as => "log_out"
get "log_in" => "sessions#new", :as => "log_in"
get "sign_up" => "users#new", :as => "sign_up"

#root :to => "sessions#new"
root to: "users#index"
resources :sessions
resources :users do
  collection { post :sort }
end
resources :questions
end
