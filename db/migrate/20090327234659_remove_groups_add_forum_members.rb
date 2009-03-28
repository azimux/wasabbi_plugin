class RemoveGroupsAddForumMembers < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.transaction do
      drop_table :wasabbi_members
      drop_table :wasabbi_groups

      create_table :wasabbi_forum_members, :id => false do |t|
        t.integer :forum_id, :null => false,
          :references => "wasabbi_forums"
        t.integer :wasabbi_user_id, :null => false
      end

      add_index :wasabbi_forum_members, :wasabbi_user_id
      add_index :wasabbi_forum_members, [:forum_id, :wasabbi_user_id],
        :unique => true

      rename_column :wasabbi_forums, :inherits_groups, :inherits_members
    end
  end

  def self.down
    ActiveRecord::Base.transaction do
      raise "can't go back."
    end
  end
end
