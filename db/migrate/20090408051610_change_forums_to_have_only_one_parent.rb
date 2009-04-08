class ChangeForumsToHaveOnlyOneParent < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.transaction do
      add_column :wasabbi_forums, :parent_id, :integer,
        :references => :wasabbi_forums

      select_rows("SELECT parent_id, child_id FROM
        wasabbi_forum_children").each do |row|
        parent = row[0].to_i
        child = row[1].to_i

        c = WasabbiForum.find(child)
        c.parent_id = parent
        c.save!
      end

      drop_table :wasabbi_forum_children
    end
  end

  def self.down
    ActiveRecord::Base.transaction do
      raise "can't go back!"
    end
  end
end
