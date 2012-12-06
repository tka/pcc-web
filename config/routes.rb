PccWeb::Application.routes.draw do
  resource  :search, :controller => :search do
    get :result
  end
  resources :procurements
  match '/json/:year/:type/:name' => redirect('/fake_json/view1.json')
  root :to => 'search#show'
end
