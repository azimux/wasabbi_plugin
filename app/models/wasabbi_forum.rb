class WasabbiForum < ActiveRecord::Base
  cols = [:parent, :child]

  [cols,cols.reverse].each do |top,bot|
    has_and_belongs_to_many bot.to_s.pluralize,
      :class_name => "WasabbiForum",
      :join_table => :wasabbi_forum_children,
      :association_foreign_key => "#{bot}_id",
      :foreign_key => "#{top}_id"
  end

  has_string_hash :wasabbi_forum_options

  def subcategories
    children.select {|child| child.is_category}
  end

  def subforums
    children.select {|child| !child.is_category}
  end

  def page_of_threads page, limit

  end
end
