module HelloEngine
  VERSION = "0.0.1"
  class Engine < ::Rails::Engine
    isolate_namespace HelloEngine
  end
end
