class CreateForumStringOptions < ActiveRecord::Migration
  extend Azimux::HashAssociationProxy::Migration
  
  def self.up
    ActiveRecord::Base.transaction do
      add_hash_association_table :wasabbi_forum_string_options
    end
  end

  def self.down
    ActiveRecord::Base.transaction do
      remove_hash_association_table :wasabbi_forum_string_options
    end
  end
end
