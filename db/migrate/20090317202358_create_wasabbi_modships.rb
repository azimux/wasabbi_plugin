class CreateWasabbiModships < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.transaction do
      create_table :wasabbi_modships do |t|
        t.integer :wasabbi_user_id, :null => false
        t.boolean :is_super_mod, :null => false, :default => false
        t.integer :forum_id, :references => 'wasabbi_forums'
        t.boolean :is_subforum_mod, :null => false, :default => true

        t.timestamps
      end
      
      %w(wasabbi_user forum).each do |c|
        add_index :wasabbi_modships, "#{c}_id"
      end
    end
  end

  def self.down
    ActiveRecord::Base.transaction do
      drop_table :wasabbi_modships
    end
  end
end
