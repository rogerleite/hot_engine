module HotEngine

  class Motor

    attr_reader :engine_box, :at

    # Public: Find a motor or build a new one if necessary.
    #
    # engine_box - EngineBox instance.
    #
    # Returns Motor instance from engine_box.
    def self.find_or_build(engine_box)
      return engine_box.motor if engine_box.motor.kind_of?(HotEngine::Motor)
      motor = self.new(engine_box) # build a new one!
      engine_box.motor = motor
      motor
    end

    def initialize(engine_box)
      @engine_box = engine_box
      @mounted = false
    end

    def mounted?
      @mounted
    end

    def on(at)
      raise ArgumentError, "You need to specify at parameter. Example: 'hello_world'" if at.nil? || at.empty?
      raise ArgumentError, "Engine #{engine_box.name} already turned on! :X" if self.mounted?

      @at = at
      @mounted = true
    end

    def off
      raise ArgumentError, "Engine #{engine_box.name} not on! :X" unless self.mounted?
      @at = nil
      @mounted = false
    end

  end

end
