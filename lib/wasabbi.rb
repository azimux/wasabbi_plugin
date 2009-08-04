class Wasabbi
  def self.theme
    return @theme if @theme
    @theme = DefaultWasabbiTheme.new("default")

    @theme
  end

  def self.wasabbi_root
    File.join(File.dirname(__FILE__), '..')
  end

  cattr_accessor :user_class
end
