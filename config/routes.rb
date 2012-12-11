PccWeb::Application.routes.draw do
  resource  :search, :controller => :search do
    get :result
  end
  resources :procurements
  resources :tenderers
  match '/json/:year/:type/:name' => redirect('/fake_json/view1.json')
  root :to => 'search#show'
end
