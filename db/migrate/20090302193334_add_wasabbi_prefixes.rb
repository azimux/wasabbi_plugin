class AddWasabbiPrefixes < ActiveRecord::Migration
  def self.to_fix
    %w(forums forum_options forum_categories)
  end

  def self.up
    ActiveRecord::Base.transaction do
      conn = ActiveRecord::Base.connection
      to_fix.each do |t|
        new_t = "wasabbi_#{t}"
        if conn.tables.include?(t) && !conn.tables.include?(new_t)
          rename_table t, new_t
        end
      end
      
      conn.reconnect!
      
      diff = conn.tables & to_fix
      
      raise "hmmm, didn't rename the following: #{diff.join(", ")}" unless diff.empty?
    end
  end

  def self.down
    #XXX raise "no turning back!"
    ActiveRecord::Base.transaction do
      conn = ActiveRecord::Base.connection
      to_fix.each do |t|
        new_t = t.gsub(/^wasabbi_/,"")
        if conn.tables.include? t && !conn.tables.include?(new_t)
          rename_table t, new_t
        end
      end
    end
  end
end
