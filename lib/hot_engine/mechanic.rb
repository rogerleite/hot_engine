require "hot_engine/motor"

module HotEngine

  class Mechanic

    def initialize
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
      mount_at = "/#{mount_at}" unless mount_at.starts_with?("/")

      motor = Motor.find_or_build(engine_box)
      motor.on(mount_at)

      @mounted_engines << engine_box
      app_routes_redraw(@mounted_engines)

      engine_box
    end

    def unmount(engine_box)
      motor = Motor.find_or_build(engine_box)
      motor.off

      @mounted_engines.delete(engine_box)
      app_routes_redraw(@mounted_engines)

      engine_box
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
      app.routes_reloader.reload!
      Rails.logger.info "[HOT] Restoring app routes!"

      begin # mount engines like magic
        app.routes.disable_clear_and_finalize = true
        app.routes.draw do
          engines.each do |engine_box|
            Rails.logger.info "[HOT] Mounting #{engine_box.name} at: #{engine_box.mount_at.inspect}"
            mount engine_box._internal_engine, :at => engine_box.mount_at
          end
        end
      ensure
        app.routes.disable_clear_and_finalize = false
      end
    end

    def app
      Rails.application
    end

  end

  def self.mechanic
    @mechanic ||= HotEngine::Mechanic.new
  end

end
