Dir.chdir File.dirname(__FILE__) do
  Dir["*create_forum_options.rb"].each do |f|
    require f
  end
end


class DropForumOptions < ActiveRecord::Migration
  def self.up
    CreateForumOptions.down
  end

  def self.down
    CreateForumOptions.up
  end
end
