class WasabbiGroup < ActiveRecord::Base
  has_and_belongs_to_many :members,
    :class_name => "WasabbiUser",
    :join_table => "wasabbi_members",
    :foreign_key => "group_id",
    :association_foreign_key => "wasabbi_user_id"

  belongs_to :forum, :class_name => "WasabbiForum"
end
