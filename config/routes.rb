# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'beers#index'

  resources :beers, only: %i[index show update destroy]
end
