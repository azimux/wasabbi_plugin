module WasabbiPlugin
  class Engine < Rails::Engine
    config.autoload_paths << File.expand_path("..", __FILE__)

    ActiveRecord::Migrator.migrations_paths <<
        File.expand_path(File.join(File.dirname(__FILE__), "..", "db", "migrate"))

    initializer "wasabbi_plugin" do
      ActionController::Base.send(:include, ::Wasabbi::AppHelper)
      ActionView::Base.send(:include, ::Wasabbi::AppHelper)

      Find.find(File.join(File.dirname(__FILE__), "extensions")) do |p|
        p = p.to_s
        if p =~ /\.rb$/ && p !~ /\.svn/
          require p
        end
      end

#these are required because Wassabi has a configuration field (user_class)
#and wasabbi_user is modified by this field.  This causes trouble in development
#mode when Rails unloads/reloads the class.
      require 'wasabbi'
      require 'wasabbi_user'
    end
  end
end