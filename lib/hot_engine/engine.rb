require "hot_engine/mechanic"

module HotEngine

  class Engine < ::Rails::Engine
    isolate_namespace HotEngine
  end

end
