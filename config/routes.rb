Rails.application.routes.draw do
  devise_scope :athlete do
    get '/athletes/sign_up/:coach_id', :to => 'athletes/registrations#new', as: :new_coach_athlete_registration
  end

  devise_for :athletes, :controllers => { registrations: 'athletes/registrations', passwords: 'athletes/passwords'}, :path_names => { sign_up: ''}

  devise_for :coaches, controllers: { registrations: "coaches/registrations" }
  root to: "home#index"

  resources :coaches, :only => [:show] do
    resources :athletes
  end

  resources :athletes, :only => [] do
    resources :workouts
  end

  resources :about, :only => [:index]


  post 'coaches/:id/invite', to: 'athletes#invite', as: :invite
end
