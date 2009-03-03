class WasabbiTheme
  attr_accessor :name
  def initialize(name)
    self.name = name
  end

  def stylesheet_url
    resource_url('stylesheet.css')
  end

  def theme_dir
    File.join Wasabbi.wasabbi_root, 'themes', name
  end

  def theme_url
    "/vendor/plugins/wasabbi_plugin/themes/#{name}/"
  end

  def resource_url resource
    "#{theme_url}#{resource}"
  end

  def find_resouce(resource)
    File.join theme_dir, resource
  end
end
