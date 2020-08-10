Rails.application.routes.draw do
  root 'index#main'
  get '/:page', to: 'index#main'  # handle manually navigating to results page by page number => TODO: handle if page number is too high
  post '/:page', to: 'index#main', as: 'main'
end
