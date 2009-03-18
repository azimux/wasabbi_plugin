class WasabbiUser < ActiveRecord::Base
  belongs_to :user, :class_name => Wasabbi.user_class.name
end
