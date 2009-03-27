class WasabbiModification < ActiveRecord::Base
  belongs_to :post, :class_name => "WasabbiPost"
  belongs_to :wasabbi_user

  def initialize *args
    super *args
    self.quantity ||= 0
  end
end
