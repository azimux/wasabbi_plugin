class AddSomeDefaultRanks < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.transaction do
      WasabbiRank.create!([
          {:name => "New car smell", :lbound => 1, :rbound => 50},
          {:name => "Regular", :lbound => 51, :rbound => 1000},
          {:name => "Pro poster", :lbound => 1000, :rbound => 10000},
        ])
    end
  end

  def self.down
    ActiveRecord::Base.transaction do
      WasabbiRank.find_all_by_name("Regular", "Pro poster", "NewCarSmell").each do |rank|
        rank.destroy
      end
    end
  end
end
