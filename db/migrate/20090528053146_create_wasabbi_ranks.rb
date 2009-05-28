class CreateWasabbiRanks < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.transaction do
      create_table :wasabbi_ranks do |t|
        t.string :name, :null => false
        t.integer :lbound, :null => false
        t.integer :rbound, :null => false

        t.timestamps
      end

      add_column :wasabbi_users, :custom_rank, :string
    end
  end

  def self.down
    ActiveRecord::Base.transaction do
      remove_column :wasabbi_users, :custom_rank

      drop_table :wasabbi_ranks
    end
  end
end
