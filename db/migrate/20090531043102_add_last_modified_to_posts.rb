class AddLastModifiedToPosts < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.transaction do
      add_column :wasabbi_posts, :last_modified_at, :datetime
    end
  end

  def self.down
    ActiveRecord::Base.transaction do
      remove_column :wasabbi_posts, :last_modified_at
    end
  end
end
