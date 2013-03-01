require_dependency "hot_engine/application_controller"

module HotEngine

  # Wrapper to Rails::Engine
  class EngineBox

    attr_accessor :mount_at

    def initialize(rails_engine)
      @rails_engine = rails_engine
    end

    def _internal_engine
      @rails_engine
    end

    def id
      _internal_engine.object_id
    end

    def name
      _internal_engine.engine_name
    end

    def path
      _internal_engine.root.to_path
    end

    def isolated?
      _internal_engine.isolated?
    end

    def inspect
      "#<HotEngine::EngineBox:#{id} id=#{id} name=#{name.inspect} >"
    end
  end

  class Engineer

    def self.all
      @engines ||= Rails::Engine::Railties.engines.map do |e|
        EngineBox.new(e)
      end
    end

    def self.find(engine_id)
      engine = self.find!(engine_id)
      raise ArgumentError, "Engine #{engine_id} not found" if engine.nil?
      engine
    end

    def self.find!(engine_id)
      engine_id = engine_id.to_i
      all.detect { |engine| engine.id == engine_id }
    end

    def self.find_by_name(name)
      name = name.to_s
      engine = all.detect { |engine| engine.name == name }

      raise ArgumentError, "Engine #{name} not found" if engine.nil?
      engine
    end

  end

  class EnginesController < ApplicationController

    def index
      @engines = HotEngine::Engineer.all
    end

    def mount
      engine_box = HotEngine::Engineer.find_by_name(params[:name])
      HotEngine.mechanic.mount(engine_box, :at => params[:at].to_s)

      redirect_to "/engines"
    end

  end

end
