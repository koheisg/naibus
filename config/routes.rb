Rails.application.routes.draw do
  root "top#show"
  post 'slack/endpoint', to: 'slack#endpoint'
end
