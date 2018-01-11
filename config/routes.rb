Rails.application.routes.draw do
  root 'home_page#index'

  resources :chunked_upload_tasks, only: %i[create]
end
