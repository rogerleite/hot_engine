require_dependency "hot_engine/application_controller"

module HotEngine

  class EnginesController < ApplicationController

    def index
      @engines = HotEngine::Engineer.all
    end

    def mount
      HotEngine.mechanic.mount(engine_box, :at => params[:at].to_s)
      redirect_to root_path
    end

    def unmount
      HotEngine.mechanic.unmount(engine_box)
      redirect_to root_path
    end

    protected

    def engine_box
      @engine_box ||= HotEngine::Engineer.find_by_name(params[:name])
    end

  end

end
