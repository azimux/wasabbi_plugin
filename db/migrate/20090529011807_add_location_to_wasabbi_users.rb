class AddLocationToWasabbiUsers < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.transaction do
      add_column :wasabbi_users, :location, :string
    end
  end

  def self.down
    ActiveRecord::Base.transaction do
      remove_column :wasabbi_users, :location
    end
  end
end
