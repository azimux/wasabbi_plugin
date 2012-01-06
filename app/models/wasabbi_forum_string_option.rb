class WasabbiForumStringOption < ActiveRecord::Base
  belongs_to :forum, :class_name => "WasabbiForum"

  class << self
    def possible_key_values
      booleans = ["true", "false"]

      {
        "members_only" => booleans,
        "inherits_members" => booleans,
        "inherits_mods" => booleans,
        "show_subthreads" => booleans,
        "default_theme" => ["no_theme", "default"]
      }
    end

    def possible_keys
      possible_key_values.keys
    end

    def possible_values key
      possible_key_values[key]
    end
  end

  validates :name,
    :presence => true,
    :inclusion => {:in => possible_keys},
    :uniqueness => {:scope => "forum_id"}
  validates :value,
    :presence => true,
    :wasabbi_string_option_value => true
  validates :forum_id,
    :presence => true
end
