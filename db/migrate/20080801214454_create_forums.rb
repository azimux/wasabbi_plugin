class CreateForums < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.transaction do
      create_table :wasabbi_forums do |t|
        t.string :name
        t.string :description
        t.integer :parent_id, :deferrable => true
        t.integer :wasabbi_forum_category_id, :deferrable => true

        t.timestamps
      end
    end
  end

  def self.down
    ActiveRecord::Base.transaction do
      drop_table :wasabbi_forums
    end
  end
end
