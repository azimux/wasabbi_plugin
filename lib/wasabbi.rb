class Wasabbi
  class << self
    attr_accessor :user_class, :path_prefix

    def theme
      return @theme if @theme
      @theme = DefaultWasabbiTheme.new("default")

      @theme
    end

    def wasabbi_root
      File.join(File.dirname(__FILE__), '..')
    end

    def user_class= c
      @user_class = c
      WasabbiUser.class_eval do
        belongs_to :user, :class_name => c.name
      end
    end

    def path_prefix
      @path_prefix ||= 'wasaBBi'
    end


    def layout_procs
      @layout_procs ||= {}
    end
  end
end
