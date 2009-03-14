class WasabbiForumStringOption < ActiveRecord::Base
  belongs_to :forum, :class_name => "WasabbiForum"
end
