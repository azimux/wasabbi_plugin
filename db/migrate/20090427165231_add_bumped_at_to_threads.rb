class AddBumpedAtToThreads < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.transaction do
      add_column :wasabbi_threads, :bumped_at, :datetime,
        :null => false
    end
  end

  def self.down
    ActiveRecord::Base.transaction do
      remove_column :wasabbi_threads, :bumped_at
    end
  end
end
