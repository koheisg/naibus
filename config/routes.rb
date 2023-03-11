Rails.application.routes.draw do
  namespace :admin do
    resources :chat_threads
  end
  root "top#show"
  get "slack/auth/callback", to: "slack#auth_callback"
  post 'slack/endpoint', to: 'slack#endpoint'
  resource :workspace, only: [:show, :edit, :update]
end
