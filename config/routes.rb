Rails.application.routes.draw do
  resource :password, except: [:show, :destroy]
  resource :session, only: [:new, :create, :destroy]
end
