class MakeOptionsForumIdNameIndexUnique < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.transaction do
      remove_index :wasabbi_forum_string_options, [:wasabbi_forum_id, :name]
      add_index :wasabbi_forum_string_options, [:forum_id, :name], :unique => true
    end
  end

  def self.down
    ActiveRecord::Base.transaction do
      remove_index :wasabbi_forum_string_options, [:wasabbi_forum_id, :name]
      add_index :wasabbi_forum_string_options, [:forum_id, :name]
    end
  end
end
