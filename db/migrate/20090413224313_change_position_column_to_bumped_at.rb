class ChangePositionColumnToBumpedAt < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.transaction do
      remove_column :wasabbi_thread_list_entries, :position

      add_column :wasabbi_thread_list_entries, :bumped_at, :datetime,
        :null => false

      add_index :wasabbi_thread_list_entries, [:forum_id, :bumped_at]
      add_index :wasabbi_thread_list_entries, :bumped_at
    end
  end

  def self.down
    ActiveRecord::Base.transaction do
      raise "can't go back!"
    end
  end
end
