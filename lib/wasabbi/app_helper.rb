class Wasabbi
  module AppHelper
    def self.included base
      base.extend ClassMethods
    end

    def wasabbi_check_authentication
      if !wasabbi_logged_in?
        redirect_to wasabbi_login_url
      end
    end

    def wasabbi_logged_in?
      wasabbi_current_user
    end

    def wasabbi_user
      user = wasabbi_current_user

      retval = nil

      if user
        user_id = user.send(Wasabbi.user_class.primary_key)

        retval = WasabbiUser.find_by_user_id(user_id)

        if !retval
          retval = WasabbiUser.create(:user_id => user_id)
        end
      end

      retval
    end

    module ClassMethods
      def wasabbi_require_login options = {}
        options[:except] ||= []
        if options[:except].class != Array
          options[:except] = [options[:except]]
        end

        before_filter :wasabbi_check_authentication,
          :except => [:signin, :signout] + options[:except]
      end

      def wasabbi_require_admin options = {}
        options[:except] ||= []
        if options[:except].class != Array
          options[:except] = [options[:except]]
        end

        before_filter options do |controller|
          controller.instance_eval do
            if !wasabbi_user.admin? params[:forum_id]
              redirect_to wasabbi_denied_admin_url
            end
          end
        end
      end
    end
  end
end
