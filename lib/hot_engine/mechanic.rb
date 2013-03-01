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
      raise ArgumentError, "You need to specify at parameter" if at.nil? || at.empty?
      raise ArgumentError, "Engine #{engine_box.name} already mounted" if self.mounted?

      @at = at
      @mounted = true
    end

    def off
      raise ArgumentError, "Engine #{engine_box.name} not mounted" unless self.mounted?
    end

  end

  class Mechanic

    def initialize(app)
      @app = app
      @mounted_engines = []
    end

    # Public: Add a motor on engine_box and turn on!
    #
    # engine_box - EngineBox instance
    # options - hash bag of options.
    #   :at - route path to mount engine on routes
    #
    # returns engine_box with motor.
    def mount(engine_box, options = {})
      mount_at = options[:at].to_s

      motor = Motor.find_or_build(engine_box)
      motor.on(mount_at)

      @mounted_engines << engine_box
      app_routes_redraw(@mounted_engines)

      engine_box
    end

    def unmount(engine_box)
      # remover do array
      # redraw!
    end

    protected

    # Public: Responsible to restore app's routes and mount engines parameter.
    #
    # engines - Array of EngineBox instances, to be mounted.
    #
    # returns nothing.
    def app_routes_redraw(engines)
      #debugger # all we need is love!

      # clear all routes, and load all "config/routes.rb" again
      @app.routes_reloader.reload!

      begin # mount engines like magic
        @app.routes.disable_clear_and_finalize = true
        @app.routes.draw do
          engines.each do |engine_box|
            Rails.logger.info "[HOT] Mounting #{engine_box.name} at: #{engine_box.mount_at.inspect}"
            mount engine_box._internal_engine, :at => engine_box.mount_at
          end
        end
      ensure
        @app.routes.disable_clear_and_finalize = false
      end
    end

  end

  def self.mechanic=(m)
    @mechanic = m
  end

  def self.mechanic
    @mechanic
  end

end
