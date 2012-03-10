class WasabbiThreadListEntry < ActiveRecord::Base
  set_table_name :wasabbi_thread_list_entries
  
  #acts_as_list :scope => :thread
  
  belongs_to :thread, :class_name => "WasabbiThread" #, :foreign_key => :thread_id
  belongs_to :forum, :class_name => "WasabbiForum" #, :foreign_key => :forum_id
  belongs_to :moved_to, :class_name => "WasabbiForum"

  before_create { self.bumped_at ||= Time.now }
end
