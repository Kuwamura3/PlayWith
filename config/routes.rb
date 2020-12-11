Rails.application.routes.draw do

  namespace :admin do
    resources :relationships, only: [:index]
  end

	namespace :admin do
		resources :games, only: [:index, :create, :new]
	end

	namespace :admin do
		resources :users, only: [:index, :edit, :show, :update]
	end

	devise_for :admins, controllers: {
		sessions:      'users/sessions',
		passwords:     'users/passwords',
	}

	devise_for :users, controllers: {
		sessions:      'users/sessions',
		passwords:     'users/passwords',
		registrations: 'users/registrations'
	}

	scope module: :public do
		resources :users_games, only: [:create, :destroy]
	end

	scope module: :public do
		get 'users/search'
		get 'users/gamer'
		resources :users, only: [:index, :edit, :show, :update]
	end

	scope module: :public do
		resources :relationships, only: [:index, :create, :destroy]
	end

	scope module: :public do
		root 'games#top'
		get 'about' => 'games#about'
		get 'games/search'
		resources :games, only: [:index, :create, :new]
	end

	scope module: :public do
		resources :users_comments, only: [:create]
	end

	scope module: :public do
		delete 'notifications' => 'notifications#destroy_all'
		resources :notifications, only: [:create, :destroy]
	end

	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
