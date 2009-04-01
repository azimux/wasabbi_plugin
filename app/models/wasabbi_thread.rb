class WasabbiThread < ActiveRecord::Base
  has_many :thread_list_entries, :class_name => "WasabbiThreadListEntry",
    :foreign_key => "thread_id"
  has_many :forums, :through => :thread_list_entries
  belongs_to :wasabbi_user

  belongs_to :modified_by, :class_name => "WasabbiUser"
  has_many :posts, :class_name => "WasabbiPost", :foreign_key => :thread_id

  attr_accessible :subject, :body
end