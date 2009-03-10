Dir.chdir File.dirname(__FILE__) do
  Dir["*create_forum_categories.rb"].each do |f|
    require f
  end
end

class DropUnusedCategoryColumn < ActiveRecord::Migration
  def self.up
    CreateForumCategories.down
  end

  def self.down
    CreateForumCategories.up
  end
end
