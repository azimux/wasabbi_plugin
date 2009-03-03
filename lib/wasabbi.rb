class Wasabbi
  def self.theme
    return @theme if @theme
    @theme = default_theme = WasabbiTheme.new("default")

    if !File.exists? default_theme.theme_dir
      FileUtils.cp_r File.join(wasabbi_root, 'default_theme'), default_theme.theme_dir
    end
    @theme
  end

  def self.wasabbi_root
    File.join(File.dirname(__FILE__), '..')
  end
end
