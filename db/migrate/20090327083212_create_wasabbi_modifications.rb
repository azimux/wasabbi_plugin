class CreateWasabbiModifications < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.transaction do
      create_table :wasabbi_modifications do |t|
        t.integer :wasabbi_user_id, :null => false
        t.integer :post_id, :null => false, :references => "wasabbi_posts"
        t.integer :quantity, :null => false, :default => 0

        t.timestamps
      end

      [:wasabbi_user_id, :post_id].each do |col|
        add_index :wasabbi_modifications, col
      end

      add_column :wasabbi_posts, :modified_by_others, :boolean, :null => false,
        :default => false

      rename_column :wasabbi_posts, :modifications, :modification_quantity
    end
  end

  def self.down
    ActiveRecord::Base.transaction do
      drop_table :wasabbi_modifications

      remove_column :wasabbi_posts, :modified_by_others
    end
  end
end
