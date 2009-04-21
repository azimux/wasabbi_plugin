class WasabbiUser < ActiveRecord::Base
  belongs_to :user, :class_name => Wasabbi.user_class.name
  has_many :adminships, :class_name => "WasabbiAdminship"
  has_many :modships, :class_name => "WasabbiModship"
  has_and_belongs_to_many :memberships,
    :class_name => "WasabbiForum",
    :join_table => "wasabbi_forum_members",
    :association_foreign_key => "forum_id"

  def member? forum
    return true if memberships.include? forum

    forum.inherits_members && forum.parent && member?(forum.parent)
  end

  def owns? obj
    obj.wasabbi_user_id == id
  end

  def subforum_adminships
    adminships.select(&:is_subforum_admin)
  end

  def admin? forum_id = nil, only_subs = false
    return true if super_admin?

    forum = nil

    if forum_id.is_a? WasabbiForum
      forum = forum_id
      forum_id = forum_id.id
    end

    if forum_id
      forum_id = forum_id.to_i

      admins = only_subs ? subforum_adminships : adminships

      if admins.map(&:forum_id).map(&:to_i).include?(forum_id)
        return true
      else
        forum ||= WasabbiForum.find(forum_id)

        forum.inherits_admins? && forum.parent &&
          admin?(forum.parent, true)
      end
    end
  end

  def super_admin?
    adminships.map(&:is_super_admin).any?
  end

  def subforum_modships
    modships.select(&:is_subforum_mod)
  end

  def mod? forum_id = nil, only_subs = false
    return true if admin? forum_id
    return true if modships.map(&:is_super_mod).any?

    if forum_id
      forum_id = forum_id.to_i

      mods = only_subs ? subforum_modships : modships

      if mods.map(&:forum_id).map(&:to_i).include?(forum_id)
        return true
      else
        forum = WasabbiForum.find(forum_id)

        forum.inherits_mods? && forum.parent &&
          mod?(forum.parent.id, true)
      end
    end
  end

  def after_create
    #if first user, make him super admin
    if WasabbiUser.count == 1
      if WasabbiUser.find(:first) == self
        WasabbiAdminship.create!(:wasabbi_user_id => id)
      else
        raise "only one user, but it's not this freshly created user."
      end
    end
  end
end
