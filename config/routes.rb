Rails.application.routes.draw do
  resources :products do
    collection do
      get :search
      post :auto_complete
      get  :redraw
    end
    member do
      get :confirm
    end
  end
end
