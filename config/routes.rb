LynksServiceDesk::Engine.routes.draw do
  resources :tickets, only: [:index, :create, :show, :update], defaults: {format: 'json'}
end
