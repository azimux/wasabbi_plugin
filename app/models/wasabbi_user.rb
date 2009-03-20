class WasabbiUser < ActiveRecord::Base
  belongs_to :user, :class_name => Wasabbi.user_class.name
  has_many :adminships, :class_name => "WasabbiAdminship"

  def subforum_adminships
    adminships.select {|adminship| adminship.is_subforum_admin}
  end

  def admin? forum_id = nil, subs = false
    return true if adminships.map(&:is_super_admin).any?

    if forum_id
      forum_id = forum_id.to_i

      admins = subs ? subforum_adminships : adminships


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
end
