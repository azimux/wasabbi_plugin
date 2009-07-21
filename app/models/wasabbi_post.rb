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
        :quantity => modification_quantity,
        :updated_at => last_modified_at)
    end

    if modified_by_others
      retval << wasabbi_modifications
    end

    retval.sort {|a,b| a.updated_at <=> b.updated_at}

    retval
  end

  def total_modifications
    modification_quantity +
      (modified_by_others ? modifications.map(&:quantity).sum : 0)
  end

  def modified?
    total_modifications > 0
  end
end
