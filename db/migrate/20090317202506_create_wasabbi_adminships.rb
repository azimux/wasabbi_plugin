class CreateWasabbiAdminships < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.transaction do
      create_table :wasabbi_adminships do |t|
        t.integer :wasabbi_user_id, :null => false
        t.boolean :is_super_admin, :null => false, :default => true
        t.integer :forum_id, :references => 'wasabbi_forums'
        t.boolean :is_subforum_admin, :null => false, :default => true

        t.timestamps
      end

      %w(wasabbi_user forum).each do |c|
        add_index :wasabbi_adminships, "#{c}_id"
      end
    end
  end

  def self.down
    ActiveRecord::Base.transaction do
      drop_table :wasabbi_adminships
    end
  end
end
