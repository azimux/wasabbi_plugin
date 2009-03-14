class AllowNullsInPositionColumn < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.transaction do
      change_column_null :wasabbi_thread_list_entries, :position, true
    end
  end

  def self.down
    ActiveRecord::Base.transaction do
      change_column_null :wasabbi_thread_list_entries, :position, false
    end
  end
end
