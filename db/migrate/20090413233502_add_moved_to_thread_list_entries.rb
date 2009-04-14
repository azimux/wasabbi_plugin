class AddMovedToThreadListEntries < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.transaction do
      add_column :wasabbi_thread_list_entries, :moved_to_id, :integer,
        :references => "wasabbi_forums"

      add_index :wasabbi_thread_list_entries, :moved_to_id
    end
  end

  def self.down
    ActiveRecord::Base.transaction do
      remove_column :wasabbi_thread_list_entries, :moved_to_id
    end
  end
end
