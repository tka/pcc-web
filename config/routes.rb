PccWeb::Application.routes.draw do
  resource  :search, :controller => :search do
    get :result
  end
  get '/procurements/complex_search' => 'procurements#complex_search'
  resources :procurements

  resources :tenderers
  resources :procuring_entities

  get '/company' => 'company#search'
  get '/company/search' => 'company#search'
  get '/company/complex_search' => 'company#complex_search'

  root :to => 'search#show'
end
