class WasabbiForum < ActiveRecord::Base
  has_many :threads, :through => :thread_list_entries
  has_many :thread_list_entries, :class_name => "WasabbiThreadListEntry",
    :foreign_key => "forum_id"

  has_many :modships, :class_name => "WasabbiModship", :foreign_key => "forum_id"
  has_many :adminships, :class_name => "WasabbiAdminship", :foreign_key => "forum_id"

  cols = [:parent, :child]

  [cols,cols.reverse].each do |top,bot|
    has_and_belongs_to_many bot.to_s.pluralize,
      :class_name => "WasabbiForum",
      :join_table => "wasabbi_forum_children",
      :association_foreign_key => "#{bot}_id",
      :foreign_key => "#{top}_id"
  end

  has_hash :string_options, :class_name => "WasabbiForumStringOption",
    :foreign_key => :forum_id

  def subcategories
    children.select {|child| child.is_category}
  end

  def subforums
    children.select {|child| !child.is_category}
  end

  def page_of_threads page, limit

  end
end
