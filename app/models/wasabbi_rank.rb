class WasabbiRank < ActiveRecord::Base
  def self.biggest
    all.inject {|i,j| i.rbound > j.rbound ? i : j}
  end

  validates_presence_of :name, :lbound, :rbound
  validates_numericality_of :lbound, :rbound

  def self.for_count post_count
    ranks = all

    ranks.each {|rank| return rank if rank.range === post_count}

    d = proc {|i| (i.lbound - post_count).abs}

    #find the rank with the lbound closest to this item
    ranks.inject do |i,j|
      d.call(i) < d.call(j) ? i : j
    end
  end

  def range
    lbound..rbound
  end
end
