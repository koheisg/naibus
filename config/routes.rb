require 'sidekiq/web'

Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
end

Rails.application.routes.draw do
  namespace :admin do
    mount Sidekiq::Web => '/sidekiq'
    resources :chat_threads do
      resources :mention_jobs, module: :chat_threads, only: [:create]
      resources :response_jobs, module: :chat_threads, only: [:create]
    end
  end
  root "top#show"
  get "slack/auth/callback", to: "slack#auth_callback"
  post 'slack/endpoint', to: 'slack#endpoint'
  resource :workspace, only: [:show, :edit, :update]
end
