class RemoveCategoryColumns < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.transaction do
      remove_column :wasabbi_forums, :wasabbi_forum_category_id
    end
  end

  def self.down
    ActiveRecord::Base.transaction do
      raise ActiveRecord::IrreversibleMigration
    end
  end
end
