Episode07::Application.routes.draw do

  resources :crew
  
	match "static" => "application#static"
  root :to => 'application#index'
end
