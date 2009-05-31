class RemoveModifiedById < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.transaction do
      remove_column :wasabbi_posts, :modified_by_id
    end
  end

  def self.down
    ActiveRecord::Base.transaction do
      add_column :wasabbi_posts, :modified_by_id, :integer, :references => :wasabbi_users
    end
  end
end
