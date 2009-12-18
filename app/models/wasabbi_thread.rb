class WasabbiThread < ActiveRecord::Base
  has_many :thread_list_entries, :class_name => "WasabbiThreadListEntry",
    :foreign_key => "thread_id"
  #has_many :forums, :through => :thread_list_entries
  belongs_to :wasabbi_user
  belongs_to :forum,  :class_name => "WasabbiForum"

  belongs_to :modified_by, :class_name => "WasabbiUser"
  has_many :posts, :class_name => "WasabbiPost", :foreign_key => "thread_id",
    :order => "created_at"

  attr_accessible :subject, :body

  def before_destroy
    posts.destroy_all
  end

  def posts_in_front_of(post)
    posts.count(:conditions => ["created_at < ?", post.created_at])
  end

  def bump!
    self.bumped_at = Time.now
    save!

    thread_list_entries.each do |tle|
      if !tle.moved_to
        tle.bumped_at = self.bumped_at
        tle.save!
      end
    end
  end

  def recalc_replies!
    self.replies = posts(true).count - 1
    save!
  end

  def move_to(forum)
    f = forum
    tles = []

    while f
      tle = WasabbiThreadListEntry.find_by_forum_id_and_thread_id(f.id, id)
      tle ||= WasabbiThreadListEntry.create!(:forum_id => f.id,
        :bumped_at => Time.now,
        :thread_id => id)

      tles << tle

      f = f.parent
      if f
        f = nil unless f.show_subthreads?
      end
    end

    reload
    thread_list_entries.each do |tle|
      if !tles.include?(tle)
        tle.moved_to = forum
        tle.save!
      end
    end
  end

  def last_post
    #WasabbiPost.find(:first, :conditions => ["thread_id = ?", id], :order => "created_at DESC")
    posts.find(:first, :order => "created_at DESC")
  end

  def page_of_posts(page, per = nil)
    per ||= forum.posts_per_page
    page = page.to_i

    posts.find(:all, :limit => per,
      :offset => (page - 1) * per)
  end

  def post_count
    posts.count
  end

  def to_forum
    forum
  end
end