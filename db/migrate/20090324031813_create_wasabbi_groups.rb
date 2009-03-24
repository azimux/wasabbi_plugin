class CreateWasabbiGroups < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.transaction do
      create_table :wasabbi_groups do |t|
        t.string :name

        t.timestamps
      end

      add_index :wasabbi_groups, :name, :unique => true

      create_table :wasabbi_members, :id => false do |t|
        t.integer :group_id, :references => 'wasabbi_groups',
          :null => false
        t.integer :wasabbi_user_id, :null => false

        t.timestamps
      end

      add_index :wasabbi_members, :wasabbi_user_id
      add_index :wasabbi_members, [:group_id, :wasabbi_user_id], :unique => true

      create_table :wasabbi_required_groups, :id => false do |t|
        t.integer :forum_id, :references => 'wasabbi_forums',
          :null => false
        t.integer :group_id, :references => 'wasabbi_groups',
          :null => false

        t.timestamps
      end

      add_index :wasabbi_required_groups, :group_id
      add_index :wasabbi_required_groups, [:forum_id, :group_id], :unique => true
    end
  end

  def self.down
    ActiveRecord::Base.transaction do
      drop_table :wasabbi_groups
      drop_table :wasabbi_members
      drop_table :wasabbi_required_groups
    end
  end
end
