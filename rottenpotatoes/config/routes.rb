Rottenpotatoes::Application.routes.draw do
  resources :movies do
    match "similar" => "movies#similar", via: [:get, :post]
  end
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
   
end
