Rails.application.routes.draw do
  
  namespace :users_backoffice do
    get 'welcome/index'
  end  
  namespace :site do
    get 'welcome/index'
  end
  namespace :users_backoffice do
    get 'welcome/index'
  end
  namespace :admins_backoffice do
    get 'welcome/index' # Dashboard
    resources :admins, only: [:index, :edit, :update] # Admins
  end

  devise_for :users
  devise_for :admins

  root to: 'site/welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
