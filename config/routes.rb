# frozen_string_literal: true

Rails.application.routes.draw do
  # get 'dishes/index'
  # get 'dishes/new'
  # get 'dishes/create'
  # get 'dishes/show'
  # get 'dishes/edit'
  # get 'dishes/update'
  # get 'dishes/destroy'

  resources :users
  resources :dishes
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
