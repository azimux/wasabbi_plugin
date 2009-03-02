class CreateForumOptions < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.transaction do
      create_table :wasabbi_forum_options do |t|
        t.string :name
        t.string :value
        t.integer :wasabbi_forum_id, :deferrable => true

        t.timestamps
      end
    end
  end

  def self.down
    ActiveRecord::Base.transaction do
      drop_table :wasabbi_forum_options
    end
  end
end
