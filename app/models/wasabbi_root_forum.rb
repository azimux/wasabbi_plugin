class WasabbiOnlyOneRootAllowedException < Exception
end

class WasabbiRootForum < ActiveRecord::Base
  set_table_name :wasabbi_root_forum
  belongs_to :forum, :class_name => "WasabbiForum"

  before_create do
    unless count == 0
      raise WasabbiOnlyOneRootAllowedException.new("only one root forum at a time!")
    end
  end
end
