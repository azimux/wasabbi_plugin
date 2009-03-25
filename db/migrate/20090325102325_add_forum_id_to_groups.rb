class AddForumIdToGroups < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.transaction do
      add_column :wasabbi_groups, :forum_id, :integer,
        :references => 'wasabbi_forums', :null => false

      remove_index :wasabbi_groups, :name
      add_index :wasabbi_groups, [:forum_id, :name], :unique => true
    end
  end

  def self.down
    ActiveRecord::Base.transaction do
      remove_column :wasabbi_groups, :forum_id
      add_index :wasabbi_groups, :name, :unique => true
    end
  end
end
