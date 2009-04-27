class AddPostableToForums < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.transaction do
      add_column :wasabbi_forums, :is_postable, :boolean, :null => false,
        :default => true
    end
  end

  def self.down
    ActiveRecord::Base.transaction do
      remove_column :wasabbi_forums, :is_postable
    end
  end
end
