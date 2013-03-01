module HotEngine

  class Mechanic

    def initialize(app)
      @app = app
      @mounted_engines = []
    end

    def mounted?(engine_box)
      !!@mounted_engines.detect { |e| e.id == engine_box.id}
    end

    def mount(engine_box, options = {})
      raise ArgumentError, "Engine #{engine_box.name} already mounted" if mounted?(engine_box)

      mount_at = options[:at].to_s
      raise ArgumentError, "You need to specify :at option" if mount_at.empty?

      engine_box.mount_at = mount_at
      @mounted_engines << engine_box
      app_routes_redraw(@mounted_engines)
    end

    protected

    # Public: Have to do:
    # * Clear all application routes
    # * "Draw" @app.routes
    # * "Draw" engines parameter
    #
    # engines - Array of EngineBox instances, to be mounted.
    #
    # returns nothing.
    def app_routes_redraw(engines)
      #debugger
      #puts "## app: #{@app.object_id}"
      #puts "## engines: #{engines.inspect}"

      # clear all routes, and load all "config/routes.rb" again
      @app.routes_reloader.reload!

      begin # mount engines like magic
        @app.routes.disable_clear_and_finalize = true
        @app.routes.draw do
          engines.each do |engine_box|
            Rails.logger.info "[HOT] Mounting #{engine_box.name} at: #{engine_box.mount_at}"
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

  class Engine < ::Rails::Engine
    isolate_namespace HotEngine

    attr_reader :mechanic

    config.after_initialize do |app|
      HotEngine.mechanic = Mechanic.new(app)
    end

  end

end
