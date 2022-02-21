# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'questions#index'

  resources :questions, except: :edit do
    resources :answers, shallow: true, only: %i[create update destroy] do
      member do
        delete 'destroy_attachment/:attachment_id', to: 'answers#destroy_attachment', as: :destroy_attachment
      end
    end

    member do
      post 'best_answer/:answer_id', to: 'questions#mark_best_answer', as: :best_answer
      delete 'destroy_attachment/:attachment_id', to: 'questions#destroy_attachment', as: :destroy_attach
    end
  end
end
