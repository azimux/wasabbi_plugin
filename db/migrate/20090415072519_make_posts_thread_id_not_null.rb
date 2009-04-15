class MakePostsThreadIdNotNull < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.transaction do
      change_column_null :wasabbi_posts, :thread_id, false
    end
  end

  def self.down
    ActiveRecord::Base.transaction do
      change_column_null :wasabbi_posts, :thread_id, true
    end
  end
end
