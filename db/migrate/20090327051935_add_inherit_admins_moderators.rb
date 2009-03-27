class AddInheritAdminsModerators < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.transaction do
      add_column :wasabbi_forums, :inherits_admins, :boolean,
        :null => false, :default => true
      add_column :wasabbi_forums, :inherits_mods, :boolean,
        :null => false, :default => true
      add_column :wasabbi_forums, :inherits_groups, :boolean,
        :null => false, :default => true
    end
  end

  def self.down
    ActiveRecord::Base.transaction do
      remove_column :wasabbi_forums, :inherits_admins
      remove_column :wasabbi_forums, :inherits_mods
      remove_column :wasabbi_forums, :inherits_groups
    end
  end
end
