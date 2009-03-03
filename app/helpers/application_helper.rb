# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def wasabbi_theme_stylesheet
    stylesheet_link_tag Wasabbi.theme.resource_url('stylesheet.css')
  end
  
  def wasabbi_logo
    #XXX
    ""
  end
end
