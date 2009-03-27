class WasabbiUser < ActiveRecord::Base
  belongs_to :user, :class_name => Wasabbi.user_class.name
  has_many :adminships, :class_name => "WasabbiAdminship"
  has_and_belongs_to_many :groups,
    :class_name => "WasabbiGroup",
    :join_table => "wasabbi_members",
    :association_foreign_key => "group_id"

  def owns? obj
    obj.wasabbi_user_id == id
  end

  def subforum_adminships
    adminships.select(&:is_subforum_admin)
  end

  def admin? forum_id = nil, only_subs = false
    return true if adminships.map(&:is_super_admin).any?

    if forum_id
      forum_id = forum_id.to_i

      admins = only_subs ? subforum_adminships : adminships

      if admins.map(&:forum_id).map(&:to_i).include?(forum_id)
        return true
      else
        WasabbiForum.find(forum_id).parents.each do |parent|
          if admin?(parent.id, true)
            return true
          end
        end
      end
    end

    false
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
        WasabbiForum.find(forum_id).parents.each do |parent|
          if mod?(parent.id, true)
            return true
          end
        end
      end
    end

    false
  end
end
