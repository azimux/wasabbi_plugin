class AddMissingIndexes < ActiveRecord::Migration
  def self.to_index
    {
      :wasabbi_forum_children => [:child_id, :parent_id],
      :wasabbi_forum_options => [:wasabbi_forum_id, :name],
      :wasabbi_forums => [:name]
    }
  end

  def self.up
    ActiveRecord::Base.transaction do
      remove_column :wasabbi_forums, :parent_id
      to_index.each_pair do |table,v|
        v.each do |col|
          add_index table, col
        end
      end
    end
  end

  def self.down
    ActiveRecord::Base.transaction do
      raise ActiveRecord::IrreversibleMigration

      add_column :wasabbi_forums, :parent_id, :integer, :references => nil
      to_index.each_pair do |table,v|
        v.each do |col|
          remove_index table, col
        end
      end
    end
  end
end
