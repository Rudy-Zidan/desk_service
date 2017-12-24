module LynksServiceDesk
  class Engine < ::Rails::Engine
    isolate_namespace LynksServiceDesk
    config.autoload_paths += %W(#{config.root}/lib)
  end
end
