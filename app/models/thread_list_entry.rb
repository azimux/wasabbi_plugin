class ThreadListEntry < ActiveRecord::Base
  set_table_name :wasabbi_thread_list_entries
  
  acts_as_list :scope => :thread
  
  belongs_to :wasabbi_thread
  belongs_to :wasabbi_forum
end
