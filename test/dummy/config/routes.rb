Rails.application.routes.draw do
  resources :events do
    resources :parties, shallow: true
  end

  root 'events#index'
end
