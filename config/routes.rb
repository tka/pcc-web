PccWeb::Application.routes.draw do
  resource :search
  match '/json/:year/:type/:name' => redirect('/fake_json/view1.json')
  root :to => 'search#show'
end
