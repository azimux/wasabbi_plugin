class CreateWasabbiPosts < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.transaction do
      create_table :wasabbi_posts do |t|
        t.integer :wasabbi_thread_id
        t.integer :old_thread_id, :references => "wasabbi_threads"
        t.integer :wasabbi_user_id, :null => false
        t.integer :modified_by_id, :references => "wasabbi_users"
        t.boolean :is_deleted, :null => false, :default => false
        t.text :subject, :null => false
        t.text :body, :null => false

        t.timestamps
      end

      %w(wasabbi_thread_id
         old_thread_id
         wasabbi_user_id
         modified_by_id).each do |col|
        add_index :wasabbi_posts, col
      end
    end
  end

  def self.down
    ActiveRecord::Base.transaction do
      drop_table :wasabbi_posts
    end
  end
end
