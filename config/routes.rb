Rails.application.routes.draw do
  # get '/coaches/:coach_id/athletes/new', to: 'athletes/registrations#new'
  devise_scope :athlete do
    get '/athletes/sign_up/:coach_id', :to => 'athletes/registrations#new'
  end

  devise_for :athletes, :controllers => { registrations: 'athletes/registrations'}

  devise_for :coaches, controllers: { registrations: "coaches/registrations" }
  root to: "home#index"

  resources :coaches, :only => [:show] do
    resources :athletes
  end


  post 'coaches/:id/invite', to: 'athletes#invite', as: :invite
end
