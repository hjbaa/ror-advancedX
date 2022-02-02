# frozen_string_literal: true

Rails.application.routes.draw do
  resources :questions do
    resources :answers, except: %i[index show], shallow: true
  end
end
