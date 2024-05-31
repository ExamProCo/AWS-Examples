Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get "john_blackthorne" => "application#john_blackthorne"
  put "lord_toranaga" => "application#lord_toranaga"
  post "mariko" => "application#mariko"
  get "father_alvito" => "application#father_alvito"
  get "lady_fujiko" => "application#lady_fujiko"
  put "omi" => "application#omi"
  post "ishido" => "application#ishido"
  get "lord_yabu" => "application#lord_yabu"
  get "buntaro" => "application#buntaro"
  post "kiku" => "application#kiku"
end
