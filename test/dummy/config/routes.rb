Rails.application.routes.draw do

  mount HotEngine::Engine => "/engines"
  #mount HelloEngine::Engine => "/hello"

end
