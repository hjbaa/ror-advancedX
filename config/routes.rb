# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'questions#index'

  resources :questions, except: :edit do
    resources :answers, shallow: true, only: %i[create update destroy]

    member do
      post 'best_answer/:answer_id', to: 'questions#mark_best_answer', as: :best_answer
    end
  end

  resources :attachment, only: :destroy
end
