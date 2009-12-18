String.class_eval do
  def to_forum
    raise "Bad forum ID #{self}" unless self =~ /^\s*\d+\s*$/
    self.to_i.to_forum
  end
end
