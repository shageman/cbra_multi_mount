Rails.application.routes.draw do
  get 'dashboard/index'

  mount Admin::Engine, at: "admin1", as: "admin1"
  mount Admin::Engine, at: "admin2", as: "admin2"

  root to: "dashboard#index"
end
