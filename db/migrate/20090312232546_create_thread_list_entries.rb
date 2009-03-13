class CreateThreadListEntries < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.transaction do
      create_table :wasabbi_thread_list_entries do |t|
        t.integer :wasabbi_forum_id, :null => false
        t.integer :wasabbi_thread_id, :null => false
        t.integer :position, :null => false

        t.timestamps
      end

      %w(wasabbi_thread_id).each do |col|
        add_index :wasabbi_thread_list_entries, col
      end

      add_index :wasabbi_thread_list_entries, [:wasabbi_forum_id, :position]
    end
  end

  def self.down
    ActiveRecord::Base.transaction do
      drop_table :thread_list_entries
    end
  end
end