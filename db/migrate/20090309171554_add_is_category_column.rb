class AddIsCategoryColumn < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.transaction do
      add_column :wasabbi_forums, :is_category, :boolean, :default => false
    end
  end

  def self.down
    ActiveRecord::Base.transaction do
      remove_column :wasabbi_forums, :is_category
    end
  end
end
