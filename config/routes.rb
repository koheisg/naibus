Rails.application.routes.draw do
  root "top#show"
  get 'slack/endpoint', to: 'slack#endpoint'
end
