class CreateWasabbiThreads < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.transaction do
      create_table :wasabbi_threads do |t|
        t.integer :wasabbi_user_id, :null => false
        t.text :subject, :null => false
        t.integer :views, :null => false, :default => 0
        t.integer :replies, :null => false, :default => 0
        t.boolean :is_locked, :null => false, :default => false
        t.boolean :is_deleted, :null => false, :default => false
        t.integer :modified_by_id, :references => "wasabbi_users"
        t.text :body, :null => false

        t.timestamps
      end

      %w(wasabbi_user_id modified_by_id).each do |col|
        add_index :wasabbi_threads, col
      end
    end
  end

  def self.down
    ActiveRecord::Base.transaction do
      drop_table :wasabbi_threads
    end
  end
end
