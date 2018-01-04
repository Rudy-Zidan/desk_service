LynksServiceDesk::Engine.routes.draw do
	resources :tickets, only: [:new, :index, :create, :show, :update], 
				defaults: {format: 'json'} do
		member do
			post 'transition_state'
			post 'metrics'
			post 'objects'
		end

		collection do
			get 'search'
		end
	end
end
