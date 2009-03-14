class ThreadListEntry < ActiveRecord::Base
  set_table_name :wasabbi_thread_list_entries
  
  acts_as_list :scope => :thread
  
  belongs_to :thread, :class_name => "WasabbiThread"
  belongs_to :forum, :class_name => "WasabbiForum"
end
