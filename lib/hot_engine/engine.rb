require "hot_engine/mechanic"

module HotEngine

  class Engine < ::Rails::Engine
    isolate_namespace HotEngine

    config.after_initialize do |app|
      HotEngine.mechanic = Mechanic.new(app)
    end

  end

end
