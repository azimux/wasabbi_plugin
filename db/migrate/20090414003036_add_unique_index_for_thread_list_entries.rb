class AddUniqueIndexForThreadListEntries < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.transaction do
      add_index :wasabbi_thread_list_entries, [:forum_id, :thread_id],
        :unique => true
    end
  end

  def self.down
    ActiveRecord::Base.transaction do
      remove_index :wasabbi_thread_list_entries, [:forum_id, :thread_id]
    end
  end
end
