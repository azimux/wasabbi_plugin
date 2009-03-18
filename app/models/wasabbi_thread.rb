class WasabbiThread < ActiveRecord::Base
  has_one :thread_list_entry, :class_name => "WasabbiThreadListEntry"
  belongs_to :wasabbi_user
  
  belongs_to :modified_by, :class_name => "WasabbiUser"
end
