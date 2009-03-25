class WasabbiForumStringOption < ActiveRecord::Base
  belongs_to :forum, :class_name => "WasabbiForum"
  
  def self.booleans
    ["true", "false"]
  end
  def self.possibilities
    {
      "require_login_to_read" => booleans,
      "default_theme" => ["no_theme", "default"]
    }
  end
  validates_inclusion_of :name, :in => possibilities.keys
  validates_presence_of :name, :value, :forum_id
  validates_uniqueness_of :name, :scope => 'forum_id'
end
