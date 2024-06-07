Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  match '/home', controller: 'cors', action: 'cors_preflight_check', via: [:options]

  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root to: "main#user"

  post "user", to: "main#user"

  # Defines the path of the home page (root)
  get "home", to: "main#home",  as: :home_page

  get "adminWindow", to: "main#adminWindow"

  # Defines the path of the sendPdf page
  get "uploadPdf", to: "main#uploadPdf", as: :uploadPdf_page

  # Page that makes the post
  post "postPdf", to: "main#postPdf"

  post "fill", to: "main#fill"

  post "fillAdmin", to: "main#fillAdmin"

  get "deleteWindow", to: "main#deleteWindow"
  post "deleteDate", to: "main#deleteDate"

  # Page that makes the post
  get "pdfByName", to: "main#pdfByName"

  resources :filters
  
  get 'reset', to: 'main#reset'

  resources :users

end
