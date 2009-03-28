class CreateWasabbiRootForums < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.transaction do
      create_table :wasabbi_root_forum do |t|
        t.integer :forum_id, :null => false,
          :references => "wasabbi_forums"
      end

      WasabbiRootForum.create!(
        :forum_id => (
          WasabbiForum.create!(
            :name => "All Forums",
            :description => "The root node of all forums in the system"
          ).id
        )
      )

      root = WasabbiRootForum.find(:first).forum

      root.string_options["members_only"] = "false"
      root.save!
    end
  end

  def self.down
    ActiveRecord::Base.transaction do
      drop_table :wasabbi_root_forum
      roots = WasabbiForum.find_all_by_name("root of all forums")

      raise "wtf?  multiple roots" unless roots.size == 1

      roots[0].destroy!
    end
  end
end
