Rails.application.routes.draw do
  devise_for :athletes
  devise_for :coaches
  root to: "home#index"
end
