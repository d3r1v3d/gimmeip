Gimmeip::Application.routes.draw do
    devise_for :users
    resources :ips

    root :to => 'ips#index'
end
