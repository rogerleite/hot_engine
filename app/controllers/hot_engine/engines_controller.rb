require_dependency "hot_engine/application_controller"

module HotEngine

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
