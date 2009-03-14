class WasabbiThread < ActiveRecord::Base
  has_one :thread_list_entry, :class_name => "WasabbiThreadListEntry"
end
