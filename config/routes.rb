Rails.application.routes.draw do
  root "top#show"
  get "slack/auth/callback", to: "slack#auth_callback"
  post 'slack/endpoint', to: 'slack#endpoint'
end
