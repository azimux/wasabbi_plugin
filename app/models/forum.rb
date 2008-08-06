class Forum < ActiveRecord::Base
  belongs_to :parent, :class_name => 'Forum'
  has_many :children, :class_name => 'Forum', :foreign_key => :parent_id

  has_one :forum_category
  
  has_string_hash :forum_options
end
