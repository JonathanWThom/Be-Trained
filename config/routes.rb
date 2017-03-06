Rails.application.routes.draw do
  
  devise_for :coaches, controllers: { registrations: "registrations" }
  root to: "home#index"

  resources :coaches, :only => [:show] do
    devise_for :athletes
  end

  post 'coaches/:id/invite', to: 'athletes#invite', as: :invite
end
