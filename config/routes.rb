HotEngine::Engine.routes.draw do
  get '/mount', to: 'engines#mount'
  root to: 'engines#index'
end
