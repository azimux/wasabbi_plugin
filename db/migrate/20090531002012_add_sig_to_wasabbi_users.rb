class AddSigToWasabbiUsers < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.transaction do
      add_column :wasabbi_users, :signature, :string
    end
  end

  def self.down
    ActiveRecord::Base.transaction do
      remove_column :wasabbi_users, :signature
    end
  end
end
