module HotEngine

  class Engineer

    def self.all
      @engines ||= Rails::Engine::Railties.engines.map do |e|
        EngineBox.new(e)
      end
    end

    def self.find_by_name(name)
      name = name.to_s
      engine = all.detect { |engine| engine.name == name }

      raise ArgumentError, "Engine #{name} not found" if engine.nil?
      engine
    end

  end

end
