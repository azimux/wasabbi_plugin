class Wasabbi
  def self.theme
    return @theme if @theme
    @theme = DefaultWasabbiTheme.new("default")

    @theme
  end

  def self.wasabbi_root
    File.join(File.dirname(__FILE__), '..')
  end

  cattr_accessor :user_class, :path_prefix

  def self.user_class= c
    @user_class = c
    WasabbiUser.class_eval do
      belongs_to :user, :class_name => c.name
    end
  end

  def self.path_prefix
    @path_prefix ||= 'wasaBBi'
  end


  def self.layout_procs
    @layout_procs ||= {}
  end
end
