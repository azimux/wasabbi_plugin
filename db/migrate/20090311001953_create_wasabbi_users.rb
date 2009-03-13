class CreateWasabbiUsers < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.transaction do
      create_table :wasabbi_users do |t|
        t.integer :user_id, :null => false, 
          :references => Wasabbi.user_class.table_name
        t.integer :post_count, :null => false,
          :default => 0

        t.timestamps
      end
      
      add_index :wasabbi_users, :user_id
    end
  end

  def self.down
    ActiveRecord::Base.transaction do
      drop_table :wasabbi_users
    end
  end
end
