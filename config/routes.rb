Rails.application.routes.draw do
  get "/forecast", to: "forecast#show"

  # root to: 'forecast#show'
end
