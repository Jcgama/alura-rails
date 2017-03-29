Rails.application.routes.draw do
  root 'produtos#index'
  get   'produtos/new'   => 'produtos#new'
  post  '/produtos'      => 'produtos#create'
  
end
