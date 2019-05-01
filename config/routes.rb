Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :shortened_urls, only: :create

  get '/:short_url', to: 'shortened_urls#show'
end
