ActionController::Base.send(:include, ::Wasabbi::AppHelper)
ActionView::Base.send(:include, ::Wasabbi::AppHelper)

Find.find(File.join(File.dirname(__FILE__), "lib", "extensions")) do |p|
  p = p.to_s
  require p if p =~ /\.rb$/ && p !~ /\.svn/
end

#these are required because Wassabi has a configuration field (user_class)
#and wasabbi_user is modified by this field.  This causes trouble in development
#mode when Rails unloads/reloads the class.
require 'wasabbi'
require 'wasabbi_user'