Rails.application.routes.draw do
  post 'slack/endpoint', to: 'slack#endpoint'
end
