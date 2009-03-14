class CreateThreadListEntries < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.transaction do
      create_table :wasabbi_thread_list_entries do |t|
        t.integer :forum_id, :null => false, :references => :wasabbi_forums
        t.integer :thread_id, :null => false, :references => :wasabbi_threads
        t.integer :position, :null => false

        t.timestamps
      end

      %w(thread_id).each do |col|
        add_index :wasabbi_thread_list_entries, col
      end

      add_index :wasabbi_thread_list_entries, [:forum_id, :position]
    end
  end

  def self.down
    ActiveRecord::Base.transaction do
      drop_table :wasabbi_thread_list_entries
    end
  end
end