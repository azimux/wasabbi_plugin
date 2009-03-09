class CreateForumChildrenJoinTable < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.transaction do
      create_table :wasabbi_forum_children, :id => false do |t|
        t.column :parent_id, :integer, :references => :wasabbi_forums
        t.column :child_id, :integer, :references => :wasabbi_forums
      end
    end
  end

  def self.down
    ActiveRecord::Base.transaction do
      drop_table :wasabbi_forum_children
    end
  end
end
