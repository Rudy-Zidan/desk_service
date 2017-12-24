LynksServiceDesk::Engine.routes.draw do
  resources :tickets, only: [:new, :index, :create, :show, :update], 
										  defaults: {format: 'json'}
end
