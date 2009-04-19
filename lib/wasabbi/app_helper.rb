class Wasabbi
  module AppHelper
    def self.included base
      base.extend ClassMethods
    end

    def wasabbi_owner?
      my_id = wasabbi_user.id
      if my_id && params[:id]
        begin
          object = wasabbi_class.find(params[:id])
          object.wasabbi_user_id == my_id
        rescue ActiveRecord::RecordNotFound
          nil
        end
      end
    end

    def wasabbi_class
      controller_name.singularize.camelize.constantize
    end

    def wasabbi_determine_forum_id
      if self.class == WasabbiForumsController
        if ['new','create'].include?(action_name)
          retval = params[:wasabbi_forum]
          retval &&= retval[:parent_id]
        else
          retval = params[:id]
        end
      elsif h = params[controller_name.singularize.to_sym]
        retval = h[:forum_id]
      end

      unless retval
        begin
          if wasabbi_class == WasabbiPost
            if params[:id]
              retval = wasabbi_class.find(params[:id]).thread.forum_id
            elsif params[:wasabbi_post]
              retval = WasabbiThread.find(params[:wasabbi_post][:thread_id]).forum_id
            elsif params[:thread_id]
              retval = WasabbiThread.find(params[:thread_id]).forum_id
            end
          end
        rescue NoMethodError, ActiveRecord::RecordNotFound
        end
      end

      unless retval
        begin
          tmp = wasabbi_class.find(params[:id]).forum
          retval = tmp.id if tmp.class == WasabbiForum
        rescue NoMethodError, ActiveRecord::RecordNotFound
        end
      end

      retval ||= params[:forum_id]
      if retval.is_a?(String)
        retval = nil if retval.strip == ""
      end

      retval
    end

    def wasabbi_check_authentication
      if !wasabbi_logged_in?
        redirect_to(wasabbi_login_url)
        return false
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

    private
    def wasabbi_skip_check? if_public, if_private, if_owner
      forum_id = wasabbi_determine_forum_id

      skip = wasabbi_user && wasabbi_user.super_admin?

      if forum_id
        forum = WasabbiForum.find(forum_id)

        if if_public && forum.public_forum?
          skip ||= if !if_public[:except].blank?
            if_public[:except].include?(action_name.to_sym)
          elsif !if_public[:only].blank?
            !if_public[:only].include?(action_name.to_sym)
          end
        end

        if if_private && !forum.public_forum?
          skip ||= if !if_private[:except].blank?
            if_private[:except].include?(action_name.to_sym)
          elsif !if_private[:only].blank?
            !if_private[:only].include?(action_name.to_sym)
          end
        end
      end

      if if_owner && wasabbi_owner?
        skip ||= if_owner == true

        skip ||= if !if_owner[:except].blank?
          if_owner[:except].include?(action_name.to_sym)
        elsif !if_private[:only].blank?
          !if_owner[:only].include?(action_name.to_sym)
        end
      end

      skip
    end

    public
    module ClassMethods
      def wasabbi_require_login options = {}
        if_public = options.delete(:if_public)
        if_private = options.delete(:if_private)
        if_owner = options.delete(:if_owner)

        before_filter options do |controller|
          controller.instance_eval do
            wasabbi_skip_check?(if_public,if_private, if_owner) || wasabbi_check_authentication
          end
        end
      end

      def wasabbi_require_mod options = {}
        if_public = options.delete(:if_public)
        if_private = options.delete(:if_private)
        if_owner = options.delete(:if_owner)

        before_filter options do |controller|
          controller.instance_eval do
            unless wasabbi_skip_check? if_public, if_private, if_owner
              forum_id = wasabbi_determine_forum_id

              if !wasabbi_user.mod?(forum_id) && !wasabbi_user.admin?(forum_id)
                redirect_to wasabbi_denied_mod_url
              end
            end
          end
        end
      end

      def wasabbi_require_admin options = {}
        if_public = options.delete(:if_public)
        if_private = options.delete(:if_private)
        if_owner = options.delete(:if_owner)

        before_filter options do |controller|
          controller.instance_eval do
            unless wasabbi_skip_check? if_public, if_private, if_owner
              forum_id = wasabbi_determine_forum_id

              if !wasabbi_user.admin? forum_id
                redirect_to wasabbi_denied_admin_url
              end
            end
          end
        end
      end

      def wasabbi_check_membership options = {}
        if_public = options.delete(:if_public)
        if_private = options.delete(:if_private)
        if_owner = options.delete(:if_owner)

        before_filter options do |controller|
          controller.instance_eval do
            unless wasabbi_skip_check?(if_public, if_private, if_owner)
              forum = begin
                WasabbiForum.find(wasabbi_determine_forum_id)
              rescue ActiveRecord::RecordNotFound
                nil
              end

              if forum
                if forum.members_only?
                  if !wasabbi_user.super_admin? && !wasabbi_user.member?(forum)
                    redirect_to wasabbi_denied_member_url
                  end
                end
              else
                raise Wasabbi::NoForumGiven
              end
            end
          end
        end
      end

    end
  end
end
