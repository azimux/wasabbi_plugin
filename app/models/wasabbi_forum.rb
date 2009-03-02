class WasabbiForum < ActiveRecord::Base
  belongs_to :parent, :class_name => 'WasabbiForum'
  has_many :children, :class_name => 'WasabbiForum', :foreign_key => :parent_id

  has_one :wasabbi_forum_category
  
  has_string_hash :wasabbi_forum_options
end
