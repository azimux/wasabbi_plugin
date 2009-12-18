class WasabbiForum < ActiveRecord::Base
  has_many :threads, :through => :thread_list_entries, :order => "bumped_at desc"
  has_many :direct_threads, :class_name => "WasabbiThread",
    :foreign_key => "forum_id"

  has_many :thread_list_entries, :class_name => "WasabbiThreadListEntry",
    :foreign_key => "forum_id", :order => "bumped_at desc"

  has_many :modships, :class_name => "WasabbiModship", :foreign_key => "forum_id"
  has_many :adminships, :class_name => "WasabbiAdminship", :foreign_key => "forum_id"

  has_and_belongs_to_many :direct_members,
    :class_name => "WasabbiUser",
    :join_table => "wasabbi_forum_members",
    :foreign_key => "forum_id"

  has_many :children, :class_name => "WasabbiForum",
    :foreign_key => "parent_id"
  belongs_to :parent, :class_name => "WasabbiForum"

  has_hash :string_options, :class_name => "WasabbiForumStringOption",
    :foreign_key => :forum_id, :key_column => "name"

  validates_associated :all_string_options

  def all_members
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

  def page_of_threads page = 1, limit = 25
    page = page.to_i
    thread_list_entries.find(:all, :offset => (page - 1) * limit, :limit => limit)
  end

  def thread_count
    thread_list_entries.count
  end

  [
    [:members_only, :inherit],
    [:inherits_admins, true],
    [:inherits_mods, true],
    [:show_subthreads, :inherit]
  ].each do |m|
    mq = nil
    d = nil

    if m.is_a?(Array)
      d = m[1]
      m = m[0]
    end

    mq = "#{m}?"
    m = m.to_s

    define_method mq do
      case string_options[m]
      when "true"
        true
      when "false"
        false
      when nil
        if d == :inherit
          parent && parent.send(mq)
        else
          d
        end
      else
        raise "invalid setting for '#{m}'"
      end
    end
  end

  def private_forum?
    members_only?
  end

  def public_forum?
    !private_forum?
  end

  def top_level?
    parent_id.nil?
  end

  def postable?
    is_postable
  end

  [
    [:posts_per_page, 15],
    [:threads_per_page, 15],
  ].each do |m|
    d = m[1]
    m = m[0].to_s

    define_method m do
      v = string_options[m]

      case v
      when /\d+/
        v.to_i
      when nil
        if parent
          parent.send(m)
        else
          d
        end
      else
        raise "invalid setting for '#{m}'"
      end
    end
  end

  def to_forum
    self
  end
end
