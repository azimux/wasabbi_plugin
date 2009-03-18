class WasabbiAdminship < ActiveRecord::Base
  belongs_to :forum, :class_name => "WasabbiForum"
  belongs_to :wasabbi_user
end
