Rails.application.routes.draw do
  root 'home_page#index'

  resources :chunked_upload_tasks, only: %i[create] do
    resources :file_chunks, only: %i[create]
  end
end
