HotEngine::Engine.routes.draw do
  get '/mount', to: 'engines#mount'
  get '/unmount', to: 'engines#unmount'
  root to: 'engines#index'
end
