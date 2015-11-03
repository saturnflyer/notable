module Notable
  class Engine < ::Rails::Engine
    isolate_namespace Notable

    initializer "notable" do |app|
      if defined?(RequestStore)
        app.config.middleware.insert_after RequestStore::Middleware, Notable::Middleware
      end
    end
  end
end
