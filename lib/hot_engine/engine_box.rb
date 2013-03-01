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

end
