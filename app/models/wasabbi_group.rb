class WasabbiGroup < ActiveRecord::Base
  has_and_belongs_to_many :members,
    :class_name => "WasabbiUser",
    :join_table => "wasabbi_members",
    :foreign_key => "group_id",
    :association_foreign_key => "wasabbi_user_id"
  has_and_belongs_to_many :required_by_forums,
    :class_name => "WasabbiForum",
    :join_table => "wasabbi_required_groups",
    :foreign_key => "group_id",
    :association_foreign_key => "forum_id"

  belongs_to :forum, :class_name => "WasabbiForum"

  def before_delete
    members.clear
    required_by_forums.clear
  end
end
