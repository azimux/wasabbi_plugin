class WasabbiForum < ActiveRecord::Base
  has_many :threads, :through => :thread_list_entries
  has_many :direct_threads, :class_name => "WasabbiThread",
    :foreign_key => "forum_id"
  has_many :thread_list_entries, :class_name => "WasabbiThreadListEntry",
    :foreign_key => "forum_id"

  has_many :modships, :class_name => "WasabbiModship", :foreign_key => "forum_id"
  has_many :adminships, :class_name => "WasabbiAdminship", :foreign_key => "forum_id"

  has_and_belongs_to_many :direct_members,
    :class_name => "WasabbiUser",
    :join_table => "wasabbi_forum_members",
    :foreign_key => "forum_id"

  #  cols = [:parent, :child]
  #  [cols,cols.reverse].each do |top,bot|
  #    has_and_belongs_to_many bot.to_s.pluralize,
  #      :class_name => "WasabbiForum",
  #      :join_table => "wasabbi_forum_children",
  #      :association_foreign_key => "#{bot}_id",
  #      :foreign_key => "#{top}_id"
  #  end

  has_many :children, :class_name => "WasabbiForum",
    :foreign_key => "forum_id"
  belongs_to :parent, :class_name => "WasabbiForum"

  has_hash :string_options, :class_name => "WasabbiForumStringOption",
    :foreign_key => :forum_id, :key_column => "name"

  validates_associated :all_string_options

  def all_members
    #    retval ||= []
    #
    #    direct_members.each {|i| retval << i}
    #
    #    if inherits_members && parent
    #      parent.all_members(retval)
    #    end
    #    retval
    #
    direct_members + (parent ? parent.all_members : [])
  end

  def before_destroy
    string_options.clear
    direct_members.clear
    [thread_list_entries,
      modships,
      adminships,
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
    members_only?
  end

  def members_only?
    case string_options["members_only"]
    when "true"
      true
    when "false"
      false
    when nil
      parent && parent.members_only?
    else
      raise "invalid setting for 'members_only'"
    end
  end

  def public_forum?
    !private_forum?
  end

  def inherits_admins?
    case string_options["inherits_admins"]
    when "true"
      true
    when "false"
      false
    when nil
      true #default to true
    else
      raise "invalid setting for 'inherits_admins'"
    end
  end

  def inherits_mods?
    case string_options["inherits_mods"]
    when "true"
      true
    when "false"
      false
    when nil
      true #default to true
    else
      raise "invalid setting for 'inherits_mods'"
    end
  end
end
