class WasabbiPost < ActiveRecord::Base
  belongs_to :thread, :class_name => "WasabbiThread"
  belongs_to :old_thread, :class_name => "WasabbiThread"
  
  belongs_to :modified_by, :class_name => "WasabbiUser"
  belongs_to :wasabbi_user

  has_many :wasabbi_modifications,
    :foreign_key => "post_id",
    :order => "updated_at",
    :dependent => :destroy

  def modifications
    retval = []

    if modification_quantity > 0
      retval << WasabbiModification.new(:wasabbi_user_id => wasabbi_user,
        :quantity => modification_quantity)
    end

    if modified_by_others
      retval << wasabbi_modifications
    end

    retval
  end

  def total_modifications
    modifications.map(&:quantity).sum
  end
end
