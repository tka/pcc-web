PccWeb::Application.routes.draw do
  resource  :search, :controller => :search do
    get :result
  end
  resources :procurements
  resources :tenderers
  resources :procuring_entities
  match '/json/:year/:type/:name' => redirect('/fake_json/view1.json')
  match '/company' => 'company#search'
  match '/company/search' => 'company#search'
  root :to => 'search#show'
end
