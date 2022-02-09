# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'questions#index'

  # delete '/answers/:id', to: 'answers#delete', as: ''
  resources :questions do
    resources :answers, only: %i[create update destroy], shallow: true
  end
end
