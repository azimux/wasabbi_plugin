class RenameForumColumnInStringOptionsTable < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.transaction do
      rename_column :wasabbi_forum_string_options, :wasabbi_forum_id, :forum_id
    end
  end

  def self.down
    ActiveRecord::Base.transaction do
      rename_column :wasabbi_forum_string_options, :forum_id, :wasabbi_forum_id
    end
  end
end
