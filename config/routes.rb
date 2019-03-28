Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :drawings
  resources :operational_surveys
  resources :reading_surveys
  resources :reports
  resources :surveys
end
