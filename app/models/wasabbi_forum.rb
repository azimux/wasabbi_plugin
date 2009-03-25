class WasabbiForum < ActiveRecord::Base
  has_many :threads, :through => :thread_list_entries
  has_many :thread_list_entries, :class_name => "WasabbiThreadListEntry",
    :foreign_key => "forum_id"

  has_many :modships, :class_name => "WasabbiModship", :foreign_key => "forum_id"
  has_many :adminships, :class_name => "WasabbiAdminship", :foreign_key => "forum_id"
  has_many :direct_groups, :class_name => "WasabbiGroup", :foreign_key => "forum_id"

  has_and_belongs_to_many :required_groups,
    :class_name => "WasabbiGroup",
    :join_table => "wasabbi_required_groups",
    :association_foreign_key => "group_id",
    :foreign_key => "forum_id"
  def all_required_groups retval = []
    retval = []

    required_groups.each {|i| retval << i}
    parents.each do |parent|
      parent.all_required_groups(retval)
    end
    retval
  end

  cols = [:parent, :child]

  [cols,cols.reverse].each do |top,bot|
    has_and_belongs_to_many bot.to_s.pluralize,
      :class_name => "WasabbiForum",
      :join_table => "wasabbi_forum_children",
      :association_foreign_key => "#{bot}_id",
      :foreign_key => "#{top}_id"
  end

  has_hash :string_options, :class_name => "WasabbiForumStringOption",
    :foreign_key => :forum_id, :key_column => "name"
  validates_associated :all_string_options

  def before_destroy
    string_options.clear
    required_groups.clear
    [thread_list_entries,
      modships,
      adminships,
      direct_groups
      ].flatten.compact.each {|ma| ma.destroy}
  end

  def all_string_options
    string_options.models
  end


  def subcategories
    children.select {|child| child.is_category}
  end

  def subforums
    children.select {|child| !child.is_category}
  end

  def page_of_threads page, limit
    #XXX
  end

  def private_forum?
    case string_options["require_login_to_read"]
    when "true"
      true
    when "false"
      false
    when nil
      if parents.empty?
        false
      else
        parents.map(&:private_forum?).all?
      end
    else
      raise "invalid setting for 'require_login_to_read'"
    end
  end

  def public_forum?
    !private_forum?
  end
end
