class WasabbiPost < ActiveRecord::Base
  belongs_to :thread, :class_name => WasabbiThread
  belongs_to :old_thread, :class_name => WasabbiThread
  
  
end
