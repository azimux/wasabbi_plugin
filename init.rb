ActionController::Base.send(:include, ::Wasabbi::AppHelper)
ActionView::Base.send(:include, ::Wasabbi::AppHelper)

Find.find(File.join(File.dirname(__FILE__), "lib", "extensions")) do |p|
  require p if p =~ /\.rb$/ && p !~ /\.svn/
end

require 'wasabbi_user'