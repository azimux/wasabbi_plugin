class Wasabbi
  module AppHelper
    def self.included base
      base.extend ClassMethods
    end

    def determine_forum_id
      params[:forum_id] || (params[:id] if self.class == WasabbiForumsController)
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
        if_public = options.delete(:if_public)
        if_private = options.delete(:if_private)

        before_filter options do |controller|
          controller.instance_eval do
            forum_id = determine_forum_id

            skip_check = false

            if forum_id
              forum = WasabbiForum.find(forum_id)
              skip_check = if if_public && forum.public_forum?
                if !if_public[:except].blank?
                  if_public[:except].include?(action_name.to_sym)
                elsif !if_public[:only].blank?
                  !if_public[:only].include?(action_name.to_sym)
                end
              elsif if_private && !forum.public_forum?
                if !if_private[:except].blank?
                  if_private[:except].include?(action_name.to_sym)
                elsif !if_private[:only].blank?
                  !if_private[:only].include?(action_name.to_sym)
                end
              end
            end

            skip_check || wasabbi_check_authentication
          end
        end
      end

      
      def wasabbi_require_mod options = {}
        before_filter options do |controller|
          controller.instance_eval do
            forum_id = determine_forum_id

            if !(wasabbi_user.mod?(forum_id) || wasabbi_user.admin?(forum_id))
              redirect_to wasabbi_denied_mod_url
            end
          end
        end
      end
      
      def wasabbi_require_admin options = {}
        before_filter options do |controller|
          controller.instance_eval do
            forum_id = determine_forum_id

            if !wasabbi_user.admin? forum_id
              redirect_to wasabbi_denied_admin_url
            end
          end
        end
      end
    end
  end
end
