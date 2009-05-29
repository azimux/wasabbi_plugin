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

  def img_dir
    File.join Wasabbi.wasabbi_root, 'themes', name, 'images'
  end

  def theme_url
    "/vendor/plugins/wasabbi_plugin/themes/#{name}"
  end

  private
  def img_lookup img
    img = img.gsub(/\.img$/, "")
    retval = img_cache[img]

    unless retval
      clear_img_cache
      retval = img_cache[img]
    end

    retval
  end

  def img_cache
    if !@img_cache
      @img_cache = {}

      FileUtils.mkdir_p img_dir

      Dir.entries(img_dir).each do |p|
        bname = File.basename(p, ".*")

        if File.extname(p) =~ /^\.(gif|png|jpg|jpeg|bmp)$/i
          raise "Duplicate image name" if @img_cache[bname]

          @img_cache[bname] = File.basename(p)
        end
      end
    end

    @img_cache
  end

  def clear_img_cache
    @img_cache = nil
  end
  public

  def resource_url resource
    if resource =~ /\.img$/
      "#{theme_url}/images/#{img_lookup(resource)}"
    else
      "#{theme_url}/#{resource}"
    end
  end

  def find_resouce(resource)
    File.join theme_dir, resource
  end
end
