Rails.application.routes.draw do
  devise_for :athletes, :controllers => { registrations: 'athletes/registrations'}

  devise_for :coaches, controllers: { registrations: "coaches/registrations" }
  root to: "home#index"

  resources :coaches, :only => [:show] do
    resources :athletes, :except => [:new]
  end

  get 'coaches/:coach_id/athletes/sign_up/', to: 'athletes/registrations#new'

  post 'coaches/:id/invite', to: 'athletes#invite', as: :invite
end
