class CreateWasabbiModifications < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.transaction do
      create_table :wasabbi_modifications do |t|
        t.integer :wasabbi_user_id, :null => false
        t.integer :post_id, :null => false, :references => "wasabbi_posts"
        t.integer :quantity, :null => false, :default => 0

        t.timestamps
      end

      add_index :wasabbi_modifications, [:post_id, :wasabbi_user_id],
        :unique => true
      add_index :wasabbi_modifications, :wasabbi_user_id
      
      add_column :wasabbi_posts, :modified_by_others, :boolean, :null => false,
        :default => false

      rename_column :wasabbi_posts, :modifications, :modification_quantity
    end
  end

  def self.down
    ActiveRecord::Base.transaction do
      drop_table :wasabbi_modifications

      remove_column :wasabbi_posts, :modified_by_others
      rename_column :wasabbi_posts, :modification_quantity, :modifications
    end
  end
end
