Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'robots#current'

  resources :robots, only: [] do
    get :current, on: :collection

    resources :movements, only: :create, controller: 'robot/movements'
    resources :positions, only: [:create], controller: 'robot/positions' do
      get :current, on: :collection
    end
  end
end
